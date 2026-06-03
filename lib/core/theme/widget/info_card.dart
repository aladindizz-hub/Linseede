import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';
import 'package:hiddify/core/theme/widget/glass_card.dart';

enum BadgeAccent { primary, secondary, success, warning, danger, neutral }

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.label,
    required this.value,
    this.secondaryLabel,
    this.secondaryValue,
    this.footer,
    this.onTap,
  });

  final String label;
  final String value;
  final String? secondaryLabel;
  final String? secondaryValue;
  final Widget? footer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;

    TextStyle labelStyle() => TextStyle(
          fontFamily: TypographyTokens.fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
          color: surface.textSecondary,
        );

    TextStyle valueStyle() => TextStyle(
          fontFamily: TypographyTokens.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 1.1,
          color: surface.textPrimary,
        );

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: RadiusTokens.medium,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: labelStyle()),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: valueStyle(),
          ),
          if (secondaryLabel != null) ...[
            const SizedBox(height: 10),
            Text(secondaryLabel!, style: labelStyle()),
          ],
          if (secondaryValue != null) ...[
            const SizedBox(height: 2),
            Text(
              secondaryValue!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: valueStyle().copyWith(fontSize: 14),
            ),
          ],
          if (footer != null) ...[
            const SizedBox(height: 8),
            footer!,
          ],
        ],
      ),
    );
  }
}

class InfoBadge extends StatelessWidget {
  const InfoBadge({
    super.key,
    required this.text,
    this.icon,
    this.accent = BadgeAccent.success,
    this.dot = false,
  });

  final String text;
  final IconData? icon;
  final BadgeAccent accent;
  final bool dot;

  Color _color(AccentTheme a, SurfaceTheme s) {
    switch (accent) {
      case BadgeAccent.primary:
        return a.primary;
      case BadgeAccent.secondary:
        return a.secondary;
      case BadgeAccent.success:
        return a.success;
      case BadgeAccent.warning:
        return a.warning;
      case BadgeAccent.danger:
        return a.danger;
      case BadgeAccent.neutral:
        return s.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentTheme = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;
    final color = _color(accentTheme, surface);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: TypographyTokens.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        if (dot)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.7), blurRadius: 6, spreadRadius: 1),
              ],
            ),
          )
        else if (icon != null)
          Icon(icon, size: 14, color: color),
      ],
    );
  }
}
