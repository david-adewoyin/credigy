import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Color(0xFF10ABDE),
          background: Color(0xFFFEFEFE),
          surface: Color(0xFFFEFEFE),
        ),
      );
}
