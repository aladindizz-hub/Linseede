import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';

enum GlassIntensity { regular, strong }

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.radius,
    this.intensity = GlassIntensity.regular,
    this.onTap,
    this.gradient,
    this.borderColor,
    this.showReflection = true,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? radius;
  final GlassIntensity intensity;
  final VoidCallback? onTap;
  final Gradient? gradient;
  final Color? borderColor;
  final bool showReflection;

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final r = radius ?? RadiusTokens.rMedium;
    final br = BorderRadius.circular(r);

    final surface = intensity == GlassIntensity.strong ? glass.surfaceStrong : glass.surface;
    final border = borderColor ?? glass.border;

    final content = Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: surface,
              gradient: gradient,
              borderRadius: br,
            ),
          ),
        ),
        if (showReflection)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: r * 1.6,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(r),
                    topRight: Radius.circular(r),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [glass.reflection, glass.reflection.withOpacity(0)],
                  ),
                ),
              ),
            ),
          ),
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: br,
                border: Border.all(color: border, width: 1),
              ),
            ),
          ),
        ),
        Padding(padding: padding, child: child),
      ],
    );

    final blurred = ClipRRect(
      borderRadius: br,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: glass.blurSigma, sigmaY: glass.blurSigma),
        child: content,
      ),
    );

    final tappable = onTap == null
        ? blurred
        : Material(
            color: Colors.transparent,
            borderRadius: br,
            child: InkWell(
              borderRadius: br,
              onTap: onTap,
              child: blurred,
            ),
          );

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: tappable,
    );
  }
}
