import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // Ocean-inspired distinctive fonts
    // Montserrat: Modern, clean, and professional for headings
    // Poppins: Friendly and readable for body text
    final textTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme).copyWith(
      displayLarge: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.displayLarge,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.displayMedium,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.displaySmall,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.headlineLarge,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.headlineMedium,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.headlineSmall,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.montserrat(
        textStyle: baseTheme.textTheme.titleLarge,
        fontWeight: FontWeight.w600,
      ),
    );

    return baseTheme.copyWith(
      textTheme: textTheme,
      // Smooth page transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Create dark theme variant (TODO: Create dark version of divercity_theme.json)
  static ThemeData createDarkTheme(ThemeData lightTheme) {
    // For now, return a basic dark theme
    // TODO: Load from assets/divercity_theme_dark.json
    final baseDark = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF36618E),
        brightness: Brightness.dark,
      ),
    );

    // Apply the same custom fonts to dark theme
    return customizeTheme(baseDark);
  }
}
