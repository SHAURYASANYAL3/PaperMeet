import { Request, Response } from 'express';
import prisma from '../utils/prisma';
import { v4 as uuidv4 } from 'uuid';

export const createMeeting = async (req: Request, res: Response) => {
  try {
    const userId = (req as any).user.userId;
    const { title, type } = req.body;

    const meeting = await prisma.meeting.create({
      data: {
        meetId: uuidv4().substring(0, 8), // simple short ID
        title: title || 'New Meeting',
        type: type || 'PRIVATE',
        hostId: userId,
      },
    });

    return res.status(201).json({ meeting });
  } catch (error) {
    console.error('Create meeting error:', error);
    return res.status(500).json({ error: 'Internal server error' });
  }
};

export const getMeeting = async (req: Request, res: Response) => {
  try {
    const { meetId } = req.params;

    const meeting = await prisma.meeting.findUnique({
      where: { meetId },
      include: { host: { select: { id: true, name: true } } },
    });

    if (!meeting) {
      return res.status(404).json({ error: 'Meeting not found' });
    }

    return res.status(200).json({ meeting });
  } catch (error) {
    return res.status(500).json({ error: 'Internal server error' });
  }
};

export const listUserMeetings = async (req: Request, res: Response) => {
  try {
    const userId = (req as any).user.userId;

    const meetings = await prisma.meeting.findMany({
      where: {
        OR: [
          { hostId: userId },
          { participants: { some: { userId } } }
        ]
      },
      orderBy: { createdAt: 'desc' },
    });

    return res.status(200).json({ meetings });
  } catch (error) {
    return res.status(500).json({ error: 'Internal server error' });
  }
};
