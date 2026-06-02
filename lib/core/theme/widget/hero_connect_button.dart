import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';

enum ConnectState { disconnected, connecting, connected, error }

class HeroConnectButton extends StatefulWidget {
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

  @override
  State<HeroConnectButton> createState() => _HeroConnectButtonState();
}

class _HeroConnectButtonState extends State<HeroConnectButton> with TickerProviderStateMixin {
  late final AnimationController _rotate;
  late final AnimationController _pulse;
  late final AnimationController _particles;

  @override
  void initState() {
    super.initState();
    _rotate = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _pulse = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat(reverse: true);
    _particles = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
  }

  @override
  void dispose() {
    _rotate.dispose();
    _pulse.dispose();
    _particles.dispose();
    super.dispose();
  }

  Color _stateColor(AccentTheme a) {
    switch (widget.state) {
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
    switch (widget.state) {
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
    final accent = Theme.of(context).extension<AccentTheme>()!;
    final surface = Theme.of(context).extension<SurfaceTheme>()!;
    final color = _stateColor(accent);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            child: AnimatedBuilder(
              animation: Listenable.merge([_rotate, _pulse, _particles]),
              builder: (context, _) {
                final pulseT = (math.sin(_pulse.value * math.pi * 2) + 1) / 2;
                final scale = widget.state == ConnectState.connected ? 1.0 + pulseT * 0.02 : 1.0;
                final rotation = widget.state == ConnectState.connecting ? _rotate.value * math.pi * 2 : 0.0;
                final glowStrength = widget.state == ConnectState.connected
                    ? 0.55 + pulseT * 0.25
                    : widget.state == ConnectState.disconnected
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
                          size: Size.square(widget.size),
                          painter: _RingPainter(
                            color: color,
                            secondary: accent.secondary,
                            sweep: widget.state == ConnectState.connecting,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _ParticlesPainter(
                          color: color,
                          progress: _particles.value,
                          intensity: widget.state == ConnectState.disconnected ? 0.4 : 1.0,
                        ),
                      ),
                    ),
                    Container(
                      width: widget.size * 0.46,
                      height: widget.size * 0.46,
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
                        size: widget.size * 0.22,
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
          widget.label ?? _defaultLabel(),
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
  bool shouldRepaint(covariant _GlowPainter old) => old.color != color || old.strength != strength;
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
