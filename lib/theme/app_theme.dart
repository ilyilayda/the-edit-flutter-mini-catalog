import 'package:flutter/material.dart';

class AppTheme {
  static const ink = Color(0xFF242638);
  static const accent = Color(0xFFF47B52);
  static const background = Color(0xFFF8F7F5);
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme:
            ColorScheme.fromSeed(seedColor: accent, surface: background),
        appBarTheme: const AppBarTheme(
            backgroundColor: background,
            foregroundColor: ink,
            elevation: 0,
            centerTitle: false),
        textTheme: const TextTheme(
            headlineMedium: TextStyle(
                fontSize: 29, fontWeight: FontWeight.w800, color: ink),
            titleLarge: TextStyle(fontWeight: FontWeight.w800, color: ink),
            bodyMedium: TextStyle(color: ink)),
        cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
      );
}
