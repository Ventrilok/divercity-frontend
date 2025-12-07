import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';

class ThemeLoader {
  /// Load theme from assets/divercity_theme.json
  static Future<ThemeData> loadTheme() async {
    try {
      final themeStr = await rootBundle.loadString('assets/divercity_theme.json');
      final themeJson = jsonDecode(themeStr);
      final theme = ThemeDecoder().decodeThemeData(themeJson, validate: true);

      if (theme == null) {
        throw Exception('Failed to decode theme from JSON');
      }

      return theme;
    } catch (e) {
      // Fallback to default Material 3 theme
      return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF36618E)),
      );
    }
  }

  /// Customize the loaded theme with additional properties
  static ThemeData customizeTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
      // Add custom fonts here when selected
      // Add custom ocean-inspired animations/transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Create dark theme variant (TODO: Create dark version of divercity_theme.json)
  static ThemeData createDarkTheme(ThemeData lightTheme) {
    // For now, return a basic dark theme
    // TODO: Load from assets/divercity_theme_dark.json
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF36618E),
        brightness: Brightness.dark,
      ),
    );
  }
}
