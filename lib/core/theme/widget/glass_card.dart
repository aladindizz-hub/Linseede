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
    final glass = Theme.of(context).extensions[GlassTheme]! as GlassTheme;
    final double r = radius ?? RadiusTokens.medium;
    final br = BorderRadius.circular(r);

    final surface = intensity == GlassIntensity.strong ? glass.surfaceStrong : glass.surface;
    final border = borderColor ?? glass.border;

    Widget content = DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        gradient: gradient,
        borderRadius: br,
        border: Border.all(color: border, width: 1),
      ),
      child: Stack(
        children: [
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
          Padding(padding: padding, child: child),
        ],
      ),
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        borderRadius: br,
        child: InkWell(
          borderRadius: br,
          onTap: onTap,
          child: content,
        ),
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ClipRRect(borderRadius: br, child: content),
    );
  }
}
