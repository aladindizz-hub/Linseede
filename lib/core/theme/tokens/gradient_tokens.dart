import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';

class GradientTokens {
  GradientTokens._();

  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.luxuryAccentBlue,
      ColorTokens.luxuryAccentPurple,
    ],
  );

  static const LinearGradient connectionActive = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.luxuryAccentCyan,
      ColorTokens.luxuryAccentBlue,
    ],
  );

  static const LinearGradient premiumGlow = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.luxuryAccentPurple,
      ColorTokens.luxuryAccentCyan,
      ColorTokens.luxuryAccentBlue,
    ],
  );

  static const LinearGradient aurora = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.luxuryAccentGreen,
      ColorTokens.luxuryAccentCyan,
      ColorTokens.luxuryAccentPurple,
    ],
  );

  static const LinearGradient royal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.royalAccentGold,
      ColorTokens.royalAccentMagenta,
    ],
  );

  static const LinearGradient arctic = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.arcticAccentSky,
      ColorTokens.arcticAccentCyan,
    ],
  );

  static const LinearGradient sakura = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.sakuraAccentPink,
      ColorTokens.sakuraAccentCoral,
    ],
  );

  static const LinearGradient carbon = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.carbonAccentSilver,
      ColorTokens.carbonAccentLime,
    ],
  );

  static const LinearGradient glassReflection = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorTokens.glassWhite14,
      ColorTokens.glassWhite04,
    ],
  );

  static const RadialGradient ambientBlue = RadialGradient(
    center: Alignment.topCenter,
    radius: 1.2,
    colors: [
      Color(0x3338BDF8),
      Color(0x00000000),
    ],
  );

  static const RadialGradient ambientPurple = RadialGradient(
    center: Alignment.bottomCenter,
    radius: 1.2,
    colors: [
      Color(0x338B5CF6),
      Color(0x00000000),
    ],
  );

  static LinearGradient diagonal(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }
}
