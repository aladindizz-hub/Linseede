import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/tokens/shadow_tokens.dart';

enum HeroConnectState { disconnected, connecting, connected }

class HeroConnectButton extends HookWidget {
  const HeroConnectButton({
    super.key,
    required this.state,
    required this.onTap,
    this.size = 220,
  });

  final HeroConnectState state;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final glass = Theme.of(context).extensions[GlassTheme]! as GlassTheme;

    final isConnected = state == HeroConnectState.connected;
    final isConnecting = state == HeroConnectState.connecting;

    final ctrl = useAnimationController(duration: const Duration(seconds: 6));
    useEffect(() {
      ctrl.repeat();
      return null;
    }, const []);

    final pulse = useAnimationController(
      duration: const Duration(milliseconds: 1800),
    );
    useEffect(() {
      if (isConnecting) {
        pulse.repeat(reverse: true);
      } else {
        pulse.stop();
        pulse.value = 0;
      }
      return null;
    }, [isConnecting]);

    final color = isConnected
        ? accent.success
        : isConnecting
            ? accent.warning
            : accent.primary;

    return RepaintBoundary(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    color.withOpacity(0.35),
                    color.withOpacity(0.0),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: ctrl,
              builder: (context, _) {
                return Transform.rotate(
                  angle: ctrl.value * 2 * math.pi,
                  child: CustomPaint(
                    size: Size(size * 0.86, size * 0.86),
                    painter: _ArcPainter(color: color),
                  ),
                );
              },
            ),
            if (isConnecting)
              AnimatedBuilder(
                animation: pulse,
                builder: (context, _) {
                  final v = pulse.value;
                  return Container(
                    width: size * (0.62 + 0.10 * v),
                    height: size * (0.62 + 0.10 * v),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color.withOpacity(0.5 * (1 - v)),
                        width: 2,
                      ),
                    ),
                  );
                },
              ),
            GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: size * 0.58,
                height: size * 0.58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      Color.lerp(color, Colors.black, 0.35)!,
                    ],
                  ),
                  border: Border.all(color: glass.border, width: 1),
                  boxShadow: [
                    ShadowTokens.glowFromColor(color, opacity: 0.45, blur: 32),
                  ],
                ),
                child: Icon(
                  Icons.power_settings_new_rounded,
                  size: size * 0.24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  _ArcPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..shader = SweepGradient(
        colors: [
          color.withOpacity(0.0),
          color.withOpacity(0.9),
          color.withOpacity(0.0),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);
    canvas.drawArc(rect.deflate(2), 0, math.pi * 1.2, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcPainter old) => old.color != color;
}
