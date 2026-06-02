import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';

@immutable
class AccentTheme extends ThemeExtension<AccentTheme> {
  const AccentTheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.success,
    required this.warning,
    required this.danger,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color success;
  final Color warning;
  final Color danger;

  static const AccentTheme luxury = AccentTheme(
    primary: ColorTokens.luxuryAccentBlue,
    secondary: ColorTokens.luxuryAccentPurple,
    tertiary: ColorTokens.luxuryAccentCyan,
    success: ColorTokens.luxuryAccentGreen,
    warning: ColorTokens.luxuryWarning,
    danger: ColorTokens.luxuryDanger,
  );

  static const AccentTheme aurora = AccentTheme(
    primary: ColorTokens.auroraAccentGreen,
    secondary: ColorTokens.auroraAccentTeal,
    tertiary: ColorTokens.auroraAccentViolet,
    success: ColorTokens.auroraAccentMint,
    warning: ColorTokens.auroraWarning,
    danger: ColorTokens.auroraDanger,
  );

  static const AccentTheme royal = AccentTheme(
    primary: ColorTokens.royalAccentGold,
    secondary: ColorTokens.royalAccentMagenta,
    tertiary: ColorTokens.royalAccentPlum,
    success: ColorTokens.royalAccentAmber,
    warning: ColorTokens.royalWarning,
    danger: ColorTokens.royalDanger,
  );

  static const AccentTheme arctic = AccentTheme(
    primary: ColorTokens.arcticAccentSky,
    secondary: ColorTokens.arcticAccentCyan,
    tertiary: ColorTokens.arcticAccentBlue,
    success: ColorTokens.arcticAccentMint,
    warning: ColorTokens.arcticWarning,
    danger: ColorTokens.arcticDanger,
  );

  static const AccentTheme sakura = AccentTheme(
    primary: ColorTokens.sakuraAccentPink,
    secondary: ColorTokens.sakuraAccentCoral,
    tertiary: ColorTokens.sakuraAccentLavender,
    success: ColorTokens.sakuraAccentRose,
    warning: ColorTokens.sakuraWarning,
    danger: ColorTokens.sakuraDanger,
  );

  static const AccentTheme carbon = AccentTheme(
    primary: ColorTokens.carbonAccentWhite,
    secondary: ColorTokens.carbonAccentLime,
    tertiary: ColorTokens.carbonAccentSilver,
    success: ColorTokens.carbonAccentLime,
    warning: ColorTokens.carbonWarning,
    danger: ColorTokens.carbonDanger,
  );

  @override
  AccentTheme copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? success,
    Color? warning,
    Color? danger,
  }) {
    return AccentTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
    );
  }

  @override
  AccentTheme lerp(ThemeExtension<AccentTheme>? other, double t) {
    if (other is! AccentTheme) return this;
    return AccentTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
    );
  }
}
