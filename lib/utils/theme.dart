import 'package:flutter/material.dart';

class AppTheme {

  static final ThemeData light = ThemeData().copyWith(
    //accentColor: Colors.lightBlueAccent,
    primaryColor: const Color(0xFF117cc1),
    primaryColorLight: const Color(0xFF5dabf4),
    primaryColorDark: const Color(0xFF0D5D91),
    indicatorColor: const Color(0xFFFFFFFF),
    bottomAppBarColor: Colors.grey[300],
    backgroundColor: Colors.grey[200],
  );

  static final ThemeData dark = ThemeData().copyWith(
    brightness: Brightness.dark,
    accentColor: Colors.lightBlueAccent,
  );

  static ThemeData setTheme(String themeName) {
    switch(themeName) {
      case 'light':
        return AppTheme.light;
      case 'dark': 
        return AppTheme.dark;
      default:
        return AppTheme.light;
    }
  }
}