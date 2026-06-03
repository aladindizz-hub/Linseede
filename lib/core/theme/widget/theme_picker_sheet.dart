import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/app_color_theme.dart';
import 'package:hiddify/core/theme/color_theme_preferences.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemePickerSheet extends ConsumerWidget {
  const ThemePickerSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const ThemePickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(colorThemePreferencesProvider);
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;

    return Container(
      decoration: BoxDecoration(
        color: surface.elevated,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(RadiusTokens.large),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: surface.textTertiary.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Тема оформления',
              style: TextStyle(
                color: surface.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Выберите палитру',
              style: TextStyle(
                color: surface.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),
            ...AppColorTheme.values.map((theme) {
              final selected = theme == current;
              final preview = theme.accents;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Material(
                  color: selected
                      ? accent.primary.withOpacity(0.12)
                      : surface.panel,
                  borderRadius: BorderRadius.circular(RadiusTokens.medium),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(RadiusTokens.medium),
                    onTap: () async {
                      await ref
                          .read(colorThemePreferencesProvider.notifier)
                          .changeColorTheme(theme);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [preview.primary, preview.secondary],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              theme.emoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  theme.displayName,
                                  style: TextStyle(
                                    color: surface.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  theme.tagline,
                                  style: TextStyle(
                                    color: surface.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (selected)
                            Icon(
                              Icons.check_circle_rounded,
                              color: accent.primary,
                              size: 22,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
