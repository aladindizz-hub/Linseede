import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';
import 'package:hiddify/core/theme/widget/glass_card.dart';

class ServerListItem extends StatelessWidget {
  const ServerListItem({
    super.key,
    required this.name,
    required this.subtitle,
    this.pingMs,
    this.leading,
    this.trailingBadge,
    this.isFavorite = false,
    this.isActive = false,
    this.onTap,
    this.onFavoriteTap,
  });

  final String name;
  final String subtitle;
  final int? pingMs;
  final Widget? leading;
  final Widget? trailingBadge;
  final bool isFavorite;
  final bool isActive;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  Color _pingColor(AccentTheme a, SurfaceTheme s) {
    final p = pingMs;
    if (p == null) return s.textTertiary;
    if (p < 80) return a.success;
    if (p < 150) return a.warning;
    return a.danger;
  }

  Widget _signalBars(Color color) {
    final p = pingMs;
    int active;
    if (p == null) {
      active = 0;
    } else if (p < 60) {
      active = 4;
    } else if (p < 100) {
      active = 3;
    } else if (p < 150) {
      active = 2;
    } else if (p < 250) {
      active = 1;
    } else {
      active = 1;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(4, (i) {
        final on = i < active;
        return Padding(
          padding: EdgeInsets.only(left: i == 0 ? 0 : 2),
          child: Container(
            width: 3,
            height: 4.0 + i * 3.0,
            decoration: BoxDecoration(
              color: on ? color : color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extension<AccentTheme>()!;
    final surface = Theme.of(context).extension<SurfaceTheme>()!;
    final pingColor = _pingColor(accent, surface);

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      radius: RadiusTokens.rMedium,
      borderColor: isActive ? accent.primary.withOpacity(0.5) : null,
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: leading ??
                  Container(
                    color: surface.elevated,
                    child: Icon(Icons.public_rounded, color: surface.textTertiary, size: 22),
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: TypographyTokens.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: surface.textPrimary,
                        ),
                      ),
                    ),
                    if (trailingBadge != null) ...[
                      const SizedBox(width: 6),
                      trailingBadge!,
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: TypographyTokens.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                    color: surface.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                pingMs == null ? '—' : '${pingMs!} ms',
                style: TextStyle(
                  fontFamily: TypographyTokens.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: pingColor,
                ),
              ),
              const SizedBox(width: 6),
              SizedBox(height: 16, child: _signalBars(pingColor)),
            ],
          ),
          const SizedBox(width: 8),
          InkResponse(
            radius: 20,
            onTap: onFavoriteTap,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                size: 22,
                color: isFavorite ? accent.warning : surface.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
