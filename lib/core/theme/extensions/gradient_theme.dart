import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';

@immutable
class GradientTheme extends ThemeExtension<GradientTheme> {
  const GradientTheme({
    required this.primary,
    required this.connectionActive,
    required this.premiumGlow,
    required this.aurora,
  });

  final LinearGradient primary;
  final LinearGradient connectionActive;
  final LinearGradient premiumGlow;
  final LinearGradient aurora;

  static const GradientTheme luxury = GradientTheme(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.luxuryAccentBlue, ColorTokens.luxuryAccentPurple],
    ),
    connectionActive: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.luxuryAccentCyan, ColorTokens.luxuryAccentBlue],
    ),
    premiumGlow: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.luxuryAccentPurple,
        ColorTokens.luxuryAccentCyan,
        ColorTokens.luxuryAccentBlue,
      ],
    ),
    aurora: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.luxuryAccentGreen,
        ColorTokens.luxuryAccentCyan,
        ColorTokens.luxuryAccentPurple,
      ],
    ),
  );

  static const GradientTheme auroraTheme = GradientTheme(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.auroraAccentGreen, ColorTokens.auroraAccentViolet],
    ),
    connectionActive: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.auroraAccentTeal, ColorTokens.auroraAccentGreen],
    ),
    premiumGlow: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.auroraAccentViolet,
        ColorTokens.auroraAccentTeal,
        ColorTokens.auroraAccentGreen,
      ],
    ),
    aurora: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.auroraAccentMint,
        ColorTokens.auroraAccentTeal,
        ColorTokens.auroraAccentViolet,
      ],
    ),
  );

  static const GradientTheme royal = GradientTheme(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.royalAccentGold, ColorTokens.royalAccentMagenta],
    ),
    connectionActive: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.royalAccentAmber, ColorTokens.royalAccentGold],
    ),
    premiumGlow: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.royalAccentMagenta,
        ColorTokens.royalAccentPlum,
        ColorTokens.royalAccentGold,
      ],
    ),
    aurora: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.royalAccentGold,
        ColorTokens.royalAccentMagenta,
        ColorTokens.royalAccentPlum,
      ],
    ),
  );

  static const GradientTheme arctic = GradientTheme(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.arcticAccentSky, ColorTokens.arcticAccentBlue],
    ),
    connectionActive: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.arcticAccentCyan, ColorTokens.arcticAccentSky],
    ),
    premiumGlow: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.arcticAccentBlue,
        ColorTokens.arcticAccentSky,
        ColorTokens.arcticAccentCyan,
      ],
    ),
    aurora: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.arcticAccentMint,
        ColorTokens.arcticAccentCyan,
        ColorTokens.arcticAccentBlue,
      ],
    ),
  );

  static const GradientTheme sakura = GradientTheme(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.sakuraAccentPink, ColorTokens.sakuraAccentCoral],
    ),
    connectionActive: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.sakuraAccentRose, ColorTokens.sakuraAccentPink],
    ),
    premiumGlow: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.sakuraAccentLavender,
        ColorTokens.sakuraAccentPink,
        ColorTokens.sakuraAccentCoral,
      ],
    ),
    aurora: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.sakuraAccentLavender,
        ColorTokens.sakuraAccentPink,
        ColorTokens.sakuraAccentRose,
      ],
    ),
  );

  static const GradientTheme carbon = GradientTheme(
    primary: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.carbonAccentSilver, ColorTokens.carbonAccentLime],
    ),
    connectionActive: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorTokens.carbonAccentWhite, ColorTokens.carbonAccentSilver],
    ),
    premiumGlow: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.carbonAccentGray,
        ColorTokens.carbonAccentSilver,
        ColorTokens.carbonAccentLime,
      ],
    ),
    aurora: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        ColorTokens.carbonAccentLime,
        ColorTokens.carbonAccentSilver,
        ColorTokens.carbonAccentWhite,
      ],
    ),
  );

  @override
  GradientTheme copyWith({
    LinearGradient? primary,
    LinearGradient? connectionActive,
    LinearGradient? premiumGlow,
    LinearGradient? aurora,
  }) {
    return GradientTheme(
      primary: primary ?? this.primary,
      connectionActive: connectionActive ?? this.connectionActive,
      premiumGlow: premiumGlow ?? this.premiumGlow,
      aurora: aurora ?? this.aurora,
    );
  }

  @override
  GradientTheme lerp(ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;
    return GradientTheme(
      primary: LinearGradient.lerp(primary, other.primary, t)!,
      connectionActive: LinearGradient.lerp(connectionActive, other.connectionActive, t)!,
      premiumGlow: LinearGradient.lerp(premiumGlow, other.premiumGlow, t)!,
      aurora: LinearGradient.lerp(aurora, other.aurora, t)!,
    );
  }
}
