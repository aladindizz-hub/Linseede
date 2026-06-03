import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';
import 'package:hiddify/core/theme/widget/glass_card.dart';

class ActiveProfileCard extends StatelessWidget {
  const ActiveProfileCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.pingMs,
    this.connectionTime,
    this.leading,
    this.onTap,
    this.onRefreshTap,
  });

  final String title;
  final String subtitle;
  final int? pingMs;
  final String? connectionTime;
  final Widget? leading;
  final VoidCallback? onTap;
  final VoidCallback? onRefreshTap;

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
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;
    final pingColor = _pingColor(accent, surface);

    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      radius: RadiusTokens.large,
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: leading ??
                  Container(
                    color: surface.elevated,
                    child: Icon(Icons.public_rounded, color: surface.textTertiary, size: 28),
                  ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: TypographyTokens.fontFamily,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: surface.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: TypographyTokens.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: surface.textSecondary,
                        ),
                      ),
                    ),
                    if (onRefreshTap != null) ...[
                      const SizedBox(width: 6),
                      InkResponse(
                        radius: 16,
                        onTap: onRefreshTap,
                        child: Icon(
                          Icons.refresh_rounded,
                          size: 16,
                          color: accent.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                    SizedBox(height: 14, child: _signalBars(pingColor)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (connectionTime != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Connection Time',
                  style: TextStyle(
                    fontFamily: TypographyTokens.fontFamily,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                    color: surface.textTertiary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  connectionTime!,
                  style: TextStyle(
                    fontFamily: TypographyTokens.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: surface.textPrimary,
                  ),
                ),
              ],
            ),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right_rounded, color: surface.textTertiary, size: 22),
        ],
      ),
    );
  }
}
