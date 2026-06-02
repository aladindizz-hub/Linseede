import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';

class GlassIconButton extends StatelessWidget {
  const GlassIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.onLongPress,
    this.size = 44,
    this.iconSize = 22,
    this.iconColor,
    this.borderRadius = 14,
    this.badge,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double size;
  final double iconSize;
  final Color? iconColor;
  final double borderRadius;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassTheme>()!;
    final surface = Theme.of(context).extension<SurfaceTheme>()!;
    final br = BorderRadius.circular(borderRadius);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          borderRadius: br,
          child: InkWell(
            borderRadius: br,
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: glass.surface,
                borderRadius: br,
                border: Border.all(color: glass.border, width: 1),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor ?? surface.textPrimary,
              ),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            top: -4,
            right: -4,
            child: badge!,
          ),
      ],
    );
  }
}
