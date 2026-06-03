import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/tokens/shadow_tokens.dart';

class LinseedeNavItem {
  const LinseedeNavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class LinseedeBottomNav extends StatelessWidget {
  const LinseedeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    this.items = const [
      LinseedeNavItem(icon: Icons.power_settings_new_rounded, label: 'Главная'),
      LinseedeNavItem(icon: Icons.settings_rounded, label: 'Настройки'),
    ],
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  final List<LinseedeNavItem> items;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final glass = Theme.of(context).extensions[GlassTheme]! as GlassTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Container(
          height: 68,
          decoration: BoxDecoration(
            color: glass.surfaceStrong,
            borderRadius: RadiusTokens.brCircular,
            border: Border.all(color: glass.border, width: 1),
            boxShadow: const [ShadowTokens.medium],
          ),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavTab(
                    item: items[i],
                    active: i == currentIndex,
                    accent: accent,
                    glass: glass,
                    surface: surface,
                    onTap: () => onChanged(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.item,
    required this.active,
    required this.accent,
    required this.glass,
    required this.surface,
    required this.onTap,
  });

  final LinseedeNavItem item;
  final bool active;
  final AccentTheme accent;
  final GlassTheme glass;
  final SurfaceTheme surface;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            gradient: active
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [accent.primary, accent.secondary],
                  )
                : null,
            borderRadius: RadiusTokens.brCircular,
            boxShadow: active
                ? [ShadowTokens.glowFromColor(accent.primary, opacity: 0.45, blur: 22)]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 20,
                color: active ? Colors.white : surface.textSecondary,
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: active
                    ? Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.2,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
