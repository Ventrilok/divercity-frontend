import 'package:flutter/material.dart';

class AppTheme {
  // Ocean-inspired custom colors (from divercity_theme.json)
  static const Color primaryBlue = Color(0xFF36618E);
  static const Color secondaryBlueGray = Color(0xFF535F70);
  static const Color tertiaryPurple = Color(0xFF6B5778);
  static const Color surfaceLight = Color(0xFFF8F9FF);

  // Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
