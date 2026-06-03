import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';
import 'package:hiddify/core/theme/widget/glass_card.dart';

enum StatAccent { primary, secondary, success, warning, danger }

class StatsCard extends StatelessWidget {
  const StatsCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    this.accent = StatAccent.primary,
    this.onTap,
  });

  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final StatAccent accent;
  final VoidCallback? onTap;

  Color _accentColor(AccentTheme a) {
    switch (accent) {
      case StatAccent.primary:
        return a.primary;
      case StatAccent.secondary:
        return a.secondary;
      case StatAccent.success:
        return a.success;
      case StatAccent.warning:
        return a.warning;
      case StatAccent.danger:
        return a.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentTheme = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;
    final color = _accentColor(accentTheme);

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      radius: RadiusTokens.medium,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.12),
              border: Border.all(color: color.withOpacity(0.35), width: 1),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: TypographyTokens.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: surface.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: TypographyTokens.fontFamily,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                    color: surface.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: TextStyle(
                  fontFamily: TypographyTokens.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: surface.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key, required this.cards, this.spacing = 10});

  final List cards;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - spacing * (cards.length - 1)) / cards.length;
        return Row(
          children: [
            for (int i = 0; i < cards.length; i++) ...[
              SizedBox(width: width, child: cards[i] as Widget),
              if (i != cards.length - 1) SizedBox(width: spacing),
            ],
          ],
        );
      },
    );
  }
}
