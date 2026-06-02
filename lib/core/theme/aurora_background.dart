import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';

class AuroraBackground extends StatelessWidget {
  const AuroraBackground({
    super.key,
    required this.child,
    this.intensity = 1.0,
  });

  final Widget child;
  final double intensity;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extension<AccentTheme>()!;
    final surface = Theme.of(context).extension<SurfaceTheme>()!;

    return DecoratedBox(
      decoration: BoxDecoration(color: surface.bgPrimary),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _AuroraPainter(
                  primary: accent.primary,
                  secondary: accent.secondary,
                  tertiary: accent.tertiary,
                  intensity: intensity,
                  isLight: surface.isLight,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.intensity,
    required this.isLight,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final double intensity;
  final bool isLight;

  @override
  void paint(Canvas canvas, Size size) {
    final blobOpacity = (isLight ? 0.18 : 0.32) * intensity;

    void blob(Offset center, double radius, Color color) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [color.withOpacity(blobOpacity), color.withOpacity(0)],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    blob(
      Offset(size.width * 0.15, size.height * 0.18),
      size.width * 0.85,
      primary,
    );
    blob(
      Offset(size.width * 0.95, size.height * 0.35),
      size.width * 0.75,
      secondary,
    );
    blob(
      Offset(size.width * 0.50, size.height * 0.78),
      size.width * 0.9,
      tertiary,
    );
    blob(
      Offset(size.width * 0.05, size.height * 0.95),
      size.width * 0.5,
      secondary,
    );
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter old) =>
      old.primary != primary ||
      old.secondary != secondary ||
      old.tertiary != tertiary ||
      old.intensity != intensity ||
      old.isLight != isLight;
}
