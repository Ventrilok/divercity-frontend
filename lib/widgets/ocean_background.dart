import 'package:flutter/material.dart';

/// Ocean-themed gradient background widget
/// Wraps child content with a beautiful ocean gradient
class OceanBackground extends StatelessWidget {
  final Widget child;
  final bool animate;
  final List<Color>? customColors;

  const OceanBackground({
    super.key,
    required this.child,
    this.animate = false,
    this.customColors,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Default ocean gradient colors
    final colors = customColors ??
        (isDark
            ? [
                const Color(0xFF001F3F), // Deep ocean blue (dark)
                const Color(0xFF003D5C), // Medium ocean blue
                const Color(0xFF00557A), // Lighter ocean blue
              ]
            : [
                const Color(0xFF0077BE), // Deep ocean blue
                const Color(0xFF00A8E8), // Medium ocean blue
                const Color(0xFF00C9FF), // Light ocean/sky blue
              ]);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: child,
    );
  }
}

/// Ocean gradient app bar background
class OceanGradientAppBar extends StatelessWidget {
  final bool isDark;

  const OceanGradientAppBar({
    super.key,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final colors = isDark
        ? [
            const Color(0xFF001F3F),
            const Color(0xFF003D5C),
          ]
        : [
            const Color(0xFF0077BE),
            const Color(0xFF00A8E8),
          ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: colors,
        ),
      ),
    );
  }
}
