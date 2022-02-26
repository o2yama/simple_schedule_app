import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final instance = AppTheme._();

  static const Color primaryColor = Colors.green;
  static final Color backGroundColor = Colors.grey[200]!;

  ThemeData themeData() {
    return ThemeData(
      primaryColor: primaryColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
      ),
    );
  }
}
