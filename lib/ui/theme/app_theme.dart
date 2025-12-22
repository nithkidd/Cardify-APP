import 'package:flutter/material.dart';

//project setup need to change later

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(useMaterial3: true, brightness: Brightness.light);
  }

  static ThemeData get darkTheme {
    return ThemeData(useMaterial3: true, brightness: Brightness.dark);
  }
}
