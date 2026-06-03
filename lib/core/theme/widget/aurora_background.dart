import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';

class AuroraBackground extends HookWidget {
  const AuroraBackground({
    super.key,
    required this.child,
    this.animate = true,
    this.intensity = 1.0,
  });

  final Widget child;
  final bool animate;
  final double intensity;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;

    final controller = useAnimationController(duration: const Duration(seconds: 24));
    useEffect(() {
      if (animate) {
        controller.repeat();
      } else {
        controller.stop();
      }
      return null;
    }, [animate]);

    return Stack(
      children: [
        Positioned.fill(
          child: ColoredBox(color: surface.background),
        ),
        Positioned.fill(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _AuroraPainter(
                  progress: controller.value,
                  intensity: intensity,
                  primary: accent.primary,
                  secondary: accent.secondary,
                  tertiary: accent.tertiary,
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: const ColoredBox(color: Color(0x00000000)),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter({
    required this.progress,
    required this.intensity,
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  final double progress;
  final double intensity;
  final Color primary;
  final Color secondary;
  final Color tertiary;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * math.pi * 2;
    final blobs = [
      _Blob(
        center: Offset(
          size.width * (0.25 + 0.08 * math.sin(t)),
          size.height * (0.22 + 0.06 * math.cos(t * 0.8)),
        ),
        radius: size.shortestSide * 0.55,
        color: primary.withOpacity(0.55 * intensity),
      ),
      _Blob(
        center: Offset(
          size.width * (0.78 + 0.05 * math.cos(t * 1.1)),
          size.height * (0.35 + 0.07 * math.sin(t * 0.9)),
        ),
        radius: size.shortestSide * 0.50,
        color: secondary.withOpacity(0.45 * intensity),
      ),
      _Blob(
        center: Offset(
          size.width * (0.55 + 0.10 * math.sin(t * 0.7)),
          size.height * (0.82 + 0.05 * math.cos(t * 1.2)),
        ),
        radius: size.shortestSide * 0.60,
        color: tertiary.withOpacity(0.40 * intensity),
      ),
    ];

    for (final b in blobs) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [b.color, b.color.withOpacity(0.0)],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: b.center, radius: b.radius));
      canvas.drawCircle(b.center, b.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter old) =>
      old.progress != progress ||
      old.intensity != intensity ||
      old.primary != primary ||
      old.secondary != secondary ||
      old.tertiary != tertiary;
}

class _Blob {
  _Blob({required this.center, required this.radius, required this.color});
  final Offset center;
  final double radius;
  final Color color;
}
