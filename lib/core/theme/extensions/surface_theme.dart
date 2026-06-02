import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';

@immutable
class SurfaceTheme extends ThemeExtension<SurfaceTheme> {
  const SurfaceTheme({
    required this.bgPrimary,
    required this.bgSecondary,
    required this.elevated,
    required this.panel,
    required this.sidebar,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textMuted,
    required this.isLight,
  });

  final Color bgPrimary;
  final Color bgSecondary;
  final Color elevated;
  final Color panel;
  final Color sidebar;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textMuted;
  final bool isLight;

  static const SurfaceTheme luxury = SurfaceTheme(
    bgPrimary: ColorTokens.luxuryBgPrimary,
    bgSecondary: ColorTokens.luxuryBgSecondary,
    elevated: ColorTokens.luxuryElevated,
    panel: ColorTokens.luxuryPanel,
    sidebar: ColorTokens.luxurySidebar,
    textPrimary: ColorTokens.textPrimary,
    textSecondary: ColorTokens.textSecondary,
    textTertiary: ColorTokens.textTertiary,
    textMuted: ColorTokens.textMuted,
    isLight: false,
  );

  static const SurfaceTheme aurora = SurfaceTheme(
    bgPrimary: ColorTokens.auroraBgPrimary,
    bgSecondary: ColorTokens.auroraBgSecondary,
    elevated: ColorTokens.auroraElevated,
    panel: ColorTokens.auroraPanel,
    sidebar: ColorTokens.auroraSidebar,
    textPrimary: ColorTokens.textPrimary,
    textSecondary: ColorTokens.textSecondary,
    textTertiary: ColorTokens.textTertiary,
    textMuted: ColorTokens.textMuted,
    isLight: false,
  );

  static const SurfaceTheme royal = SurfaceTheme(
    bgPrimary: ColorTokens.royalBgPrimary,
    bgSecondary: ColorTokens.royalBgSecondary,
    elevated: ColorTokens.royalElevated,
    panel: ColorTokens.royalPanel,
    sidebar: ColorTokens.royalSidebar,
    textPrimary: ColorTokens.textPrimary,
    textSecondary: ColorTokens.textSecondary,
    textTertiary: ColorTokens.textTertiary,
    textMuted: ColorTokens.textMuted,
    isLight: false,
  );

  static const SurfaceTheme arctic = SurfaceTheme(
    bgPrimary: ColorTokens.arcticBgPrimary,
    bgSecondary: ColorTokens.arcticBgSecondary,
    elevated: ColorTokens.arcticElevated,
    panel: ColorTokens.arcticPanel,
    sidebar: ColorTokens.arcticSidebar,
    textPrimary: ColorTokens.textPrimaryLight,
    textSecondary: ColorTokens.textSecondaryLight,
    textTertiary: ColorTokens.textTertiaryLight,
    textMuted: ColorTokens.textMutedLight,
    isLight: true,
  );

  static const SurfaceTheme sakura = SurfaceTheme(
    bgPrimary: ColorTokens.sakuraBgPrimary,
    bgSecondary: ColorTokens.sakuraBgSecondary,
    elevated: ColorTokens.sakuraElevated,
    panel: ColorTokens.sakuraPanel,
    sidebar: ColorTokens.sakuraSidebar,
    textPrimary: ColorTokens.textPrimary,
    textSecondary: ColorTokens.textSecondary,
    textTertiary: ColorTokens.textTertiary,
    textMuted: ColorTokens.textMuted,
    isLight: false,
  );

  static const SurfaceTheme carbon = SurfaceTheme(
    bgPrimary: ColorTokens.carbonBgPrimary,
    bgSecondary: ColorTokens.carbonBgSecondary,
    elevated: ColorTokens.carbonElevated,
    panel: ColorTokens.carbonPanel,
    sidebar: ColorTokens.carbonSidebar,
    textPrimary: ColorTokens.textPrimary,
    textSecondary: ColorTokens.textSecondary,
    textTertiary: ColorTokens.textTertiary,
    textMuted: ColorTokens.textMuted,
    isLight: false,
  );

  @override
  SurfaceTheme copyWith({
    Color? bgPrimary,
    Color? bgSecondary,
    Color? elevated,
    Color? panel,
    Color? sidebar,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textMuted,
    bool? isLight,
  }) {
    return SurfaceTheme(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSecondary: bgSecondary ?? this.bgSecondary,
      elevated: elevated ?? this.elevated,
      panel: panel ?? this.panel,
      sidebar: sidebar ?? this.sidebar,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textMuted: textMuted ?? this.textMuted,
      isLight: isLight ?? this.isLight,
    );
  }

  @override
  SurfaceTheme lerp(ThemeExtension<SurfaceTheme>? other, double t) {
    if (other is! SurfaceTheme) return this;
    return SurfaceTheme(
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgSecondary: Color.lerp(bgSecondary, other.bgSecondary, t)!,
      elevated: Color.lerp(elevated, other.elevated, t)!,
      panel: Color.lerp(panel, other.panel, t)!,
      sidebar: Color.lerp(sidebar, other.sidebar, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      isLight: t < 0.5 ? isLight : other.isLight,
    );
  }
}
