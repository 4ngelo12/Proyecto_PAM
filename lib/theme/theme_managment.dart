import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;


  get getThemeMode => _themeMode;

  toogleTheme(bool isdark) {
    _themeMode = isdark ? ThemeMode.dark : ThemeMode.light;
  }
}