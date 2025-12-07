import 'package:flutter/material.dart';

/// Animated Floating Action Button with ocean theme
class AnimatedOceanFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const AnimatedOceanFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  State<AnimatedOceanFAB> createState() => _AnimatedOceanFABState();
}

class _AnimatedOceanFABState extends State<AnimatedOceanFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Start pulse animation after a delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        _startPulseAnimation();
      }
    });
  }

  void _startPulseAnimation() {
    _controller.forward().then((_) {
      if (mounted) {
        _controller.reverse().then((_) {
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              _startPulseAnimation();
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: child,
          ),
        );
      },
      child: FloatingActionButton.extended(
        onPressed: () {
          _controller.forward().then((_) => _controller.reverse());
          widget.onPressed();
        },
        icon: Icon(widget.icon),
        label: Text(widget.label),
        backgroundColor: const Color(0xFF00A8E8),
        elevation: 8,
      ),
    );
  }
}

/// Simple animated FAB with scale effect
class ScaleAnimatedFAB extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Color? backgroundColor;

  const ScaleAnimatedFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
  });

  @override
  State<ScaleAnimatedFAB> createState() => _ScaleAnimatedFABState();
}

class _ScaleAnimatedFABState extends State<ScaleAnimatedFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          _controller.forward().then((_) => _controller.reverse());
          widget.onPressed();
        },
        backgroundColor: widget.backgroundColor ?? const Color(0xFF00A8E8),
        elevation: 8,
        child: widget.icon,
      ),
    );
  }
}
