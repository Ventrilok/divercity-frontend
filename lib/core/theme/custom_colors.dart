import 'package:flutter/material.dart';

/// Custom color extensions for ocean-inspired theme
class OceanColors {
  // Depth-based gradients
  static const Gradient shallowWater = LinearGradient(
    colors: [Color(0xFF4DB8E8), Color(0xFF3AA0D1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient deepWater = LinearGradient(
    colors: [Color(0xFF1E4D7B), Color(0xFF0F2744)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient sunset = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFFD93D), Color(0xFF6BCF7F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
