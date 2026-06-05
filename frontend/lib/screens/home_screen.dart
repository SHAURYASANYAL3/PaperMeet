import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'meeting_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaperMeet'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: CustomPaint(
        painter: NotebookPainter(),
        child: Padding(
          padding: const EdgeInsets.only(left: 60, top: 40, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today's Meetings",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.video_call),
                label: const Text('Start New Meeting'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MeetingScreen(meetingId: 'new')),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.group_add),
                label: const Text('Join Meeting'),
                onPressed: () {
                  // Dialog to enter meeting code
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotebookPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x330000FF)
      ..strokeWidth = 1.0;

    // Draw horizontal lines
    for (double i = 40; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Draw vertical margin line
    final marginPaint = Paint()
      ..color = const Color(0x44FF0000)
      ..strokeWidth = 2.0;
    
    canvas.drawLine(const Offset(40, 0), Offset(40, size.height), marginPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
