import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Ocean-themed gradient background widget
/// Wraps child content with a beautiful ocean gradient and optional animated waves
class OceanBackground extends StatelessWidget {
  final Widget child;
  final bool animate;
  final List<Color>? customColors;

  const OceanBackground({
    super.key,
    required this.child,
    this.animate = true,
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
      child: animate
          ? Stack(
              children: [
                // Animated waves
                const Positioned.fill(
                  child: AnimatedWaves(),
                ),
                // Content on top
                child,
              ],
            )
          : child,
    );
  }
}

/// Animated wave effect widget
class AnimatedWaves extends StatefulWidget {
  const AnimatedWaves({super.key});

  @override
  State<AnimatedWaves> createState() => _AnimatedWavesState();
}

class _AnimatedWavesState extends State<AnimatedWaves>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // First wave layer
        AnimatedBuilder(
          animation: _controller1,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                animation: _controller1.value,
                color: Colors.white.withValues(alpha: 0.03),
                amplitude: 20,
                frequency: 2,
              ),
              size: Size.infinite,
            );
          },
        ),
        // Second wave layer
        AnimatedBuilder(
          animation: _controller2,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                animation: _controller2.value,
                color: Colors.white.withValues(alpha: 0.02),
                amplitude: 30,
                frequency: 1.5,
              ),
              size: Size.infinite,
            );
          },
        ),
        // Third wave layer
        AnimatedBuilder(
          animation: _controller3,
          builder: (context, child) {
            return CustomPaint(
              painter: WavePainter(
                animation: _controller3.value,
                color: Colors.white.withValues(alpha: 0.015),
                amplitude: 25,
                frequency: 2.5,
              ),
              size: Size.infinite,
            );
          },
        ),
      ],
    );
  }
}

/// Custom painter for drawing wave shapes
class WavePainter extends CustomPainter {
  final double animation;
  final Color color;
  final double amplitude;
  final double frequency;

  WavePainter({
    required this.animation,
    required this.color,
    required this.amplitude,
    required this.frequency,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveLength = size.width;
    final offset = animation * waveLength;

    path.moveTo(0, size.height * 0.5);

    for (double x = 0; x <= size.width; x++) {
      final y = size.height * 0.5 +
          amplitude *
              math.sin((x / waveLength * frequency * 2 * math.pi) +
                  (offset / waveLength * 2 * math.pi));
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.animation != animation;
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
