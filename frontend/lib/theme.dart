import 'package:flutter/material.dart';

class NotebookTheme {
  static const Color paperBackground = Color(0xFFFDFBF7);
  static const Color blueLine = Color(0x330000FF);
  static const Color redLine = Color(0x44FF0000);
  static const Color pencilDark = Color(0xFF2C2C2C);
  static const Color pencilLight = Color(0xFF5A5A5A);
  
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: paperBackground,
      colorScheme: const ColorScheme.light(
        primary: pencilDark,
        secondary: pencilLight,
        background: paperBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: paperBackground,
        foregroundColor: pencilDark,
        elevation: 0,
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: pencilLight, width: 1.5),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: pencilDark, width: 2.0),
        ),
        labelStyle: const TextStyle(color: pencilLight),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: paperBackground,
          foregroundColor: pencilDark,
          elevation: 0,
          side: const BorderSide(color: pencilDark, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: pencilDark, fontWeight: FontWeight.bold, fontSize: 32),
        bodyLarge: TextStyle(color: pencilDark, fontSize: 18),
        bodyMedium: TextStyle(color: pencilDark, fontSize: 16),
      ),
    );
  }
}
