import { Router } from 'express';
import { createMeeting, getMeeting, listUserMeetings } from '../controllers/meeting.controller';
import { authenticate } from './auth.routes';

const router = Router();

router.use(authenticate);

router.post('/', createMeeting);
router.get('/', listUserMeetings);
router.get('/:meetId', getMeeting);

export default router;
