import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PaperMeetApp(),
    ),
  );
}

class PaperMeetApp extends StatelessWidget {
  const PaperMeetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaperMeet',
      debugShowCheckedModeBanner: false,
      theme: NotebookTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
