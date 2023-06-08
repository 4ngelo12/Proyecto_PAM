import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme  = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1E90FF)),
    scaffoldBackgroundColor: const Color(0xffdadada),
  );
  static final darkTheme  = ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF2E86C1)),
      scaffoldBackgroundColor: const Color(0xFF1B2631),

  );
}