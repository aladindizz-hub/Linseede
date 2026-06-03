import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';

enum ConnectState { disconnected, connecting, connected, error }

class HeroConnectButton extends HookWidget {
  const HeroConnectButton({
    super.key,
    required this.state,
    this.onTap,
    this.onLongPress,
    this.size = 280,
    this.label,
  });

  final ConnectState state;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double size;
  final String? label;

  Color _stateColor(AccentTheme a) {
    switch (state) {
      case ConnectState.disconnected:
        return a.primary;
      case ConnectState.connecting:
        return a.secondary;
      case ConnectState.connected:
        return a.success;
      case ConnectState.error:
        return a.danger;
    }
  }

  String _defaultLabel() {
    switch (state) {
      case ConnectState.disconnected:
        return 'Tap to Connect';
      case ConnectState.connecting:
        return 'Connecting…';
      case ConnectState.connected:
        return 'Connected';
      case ConnectState.error:
        return 'Connection error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final rotate = useAnimationController(duration: const Duration(seconds: 2))..repeat();
    final pulse = useAnimationController(duration: const Duration(milliseconds: 2400))..repeat(reverse: true);
    final particles = useAnimationController(duration: const Duration(seconds: 8))..repeat();

    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;
    final color = _stateColor(accent);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            onLongPress: onLongPress,
            child: AnimatedBuilder(
              animation: Listenable.merge([rotate, pulse, particles]),
              builder: (context, _) {
                final pulseT = (math.sin(pulse.value * math.pi * 2) + 1) / 2;
                final scale = state == ConnectState.connected ? 1.0 + pulseT * 0.02 : 1.0;
                final rotation = state == ConnectState.connecting ? rotate.value * math.pi * 2 : 0.0;
                final glowStrength = state == ConnectState.connected
                    ? 0.55 + pulseT * 0.25
                    : state == ConnectState.disconnected
                        ? 0.35
                        : 0.5;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _GlowPainter(color: color, strength: glowStrength),
                      ),
                    ),
                    Transform.scale(
                      scale: scale,
                      child: Transform.rotate(
                        angle: rotation,
                        child: CustomPaint(
                          size: Size.square(size),
                          painter: _RingPainter(
                            color: color,
                            secondary: accent.secondary,
                            sweep: state == ConnectState.connecting,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _ParticlesPainter(
                          color: color,
                          progress: particles.value,
                          intensity: state == ConnectState.disconnected ? 0.4 : 1.0,
                        ),
                      ),
                    ),
                    Container(
                      width: size * 0.46,
                      height: size * 0.46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            color.withOpacity(0.15),
                            color.withOpacity(0.02),
                          ],
                        ),
                        border: Border.all(color: color.withOpacity(0.25), width: 1),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.power_settings_new_rounded,
                        size: size * 0.22,
                        color: color,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label ?? _defaultLabel(),
          style: TextStyle(
            fontFamily: TypographyTokens.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
            color: surface.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.color, required this.secondary, required this.sweep});

  final Color color;
  final Color secondary;
  final bool sweep;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.42;

    final gradient = SweepGradient(
      colors: [
        color.withOpacity(0.0),
        color,
        secondary,
        color,
        color.withOpacity(0.0),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final rect = Rect.fromCircle(center: center, radius: radius);

    final outerStroke = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 0.5);

    final glowStroke = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    canvas.drawCircle(center, radius, glowStroke);
    canvas.drawCircle(center, radius, outerStroke);

    final innerRing = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius - 12, innerRing);
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.color != color || old.secondary != secondary || old.sweep != sweep;
}

class _GlowPainter extends CustomPainter {
  _GlowPainter({required this.color, required this.strength});

  final Color color;
  final double strength;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.46;

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(0.35 * strength),
          color.withOpacity(0.12 * strength),
          color.withOpacity(0.0),
        ],
        stops: const [0.0, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _GlowPainter old) =>
      old.color != color || old.strength != strength;
}

class _ParticlesPainter extends CustomPainter {
  _ParticlesPainter({required this.color, required this.progress, required this.intensity});

  final Color color;
  final double progress;
  final double intensity;

  static const int count = 6;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.42;

    for (int i = 0; i < count; i++) {
      final base = (i / count) * math.pi * 2;
      final angle = base + progress * math.pi * 2;
      final dx = center.dx + math.cos(angle) * radius;
      final dy = center.dy + math.sin(angle) * radius;

      final paint = Paint()
        ..color = color.withOpacity(0.85 * intensity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(Offset(dx, dy), 2.4, paint);

      final core = Paint()..color = Colors.white.withOpacity(0.9 * intensity);
      canvas.drawCircle(Offset(dx, dy), 1.2, core);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter old) =>
      old.color != color || old.progress != progress || old.intensity != intensity;
}
