import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';

@immutable
class GlassTheme extends ThemeExtension<GlassTheme> {
  const GlassTheme({
    required this.surface,
    required this.surfaceStrong,
    required this.border,
    required this.reflection,
    required this.blurSigma,
  });

  final Color surface;
  final Color surfaceStrong;
  final Color border;
  final Color reflection;
  final double blurSigma;

  static const GlassTheme dark = GlassTheme(
    surface: ColorTokens.glassWhite08,
    surfaceStrong: ColorTokens.glassWhite10,
    border: ColorTokens.glassWhite14,
    reflection: ColorTokens.glassWhite04,
    blurSigma: 32.0,
  );

  static const GlassTheme light = GlassTheme(
    surface: ColorTokens.glassBlack08,
    surfaceStrong: ColorTokens.glassBlack10,
    border: ColorTokens.glassBlack14,
    reflection: ColorTokens.glassWhite14,
    blurSigma: 32.0,
  );

  @override
  GlassTheme copyWith({
    Color? surface,
    Color? surfaceStrong,
    Color? border,
    Color? reflection,
    double? blurSigma,
  }) {
    return GlassTheme(
      surface: surface ?? this.surface,
      surfaceStrong: surfaceStrong ?? this.surfaceStrong,
      border: border ?? this.border,
      reflection: reflection ?? this.reflection,
      blurSigma: blurSigma ?? this.blurSigma,
    );
  }

  @override
  GlassTheme lerp(ThemeExtension<GlassTheme>? other, double t) {
    if (other is! GlassTheme) return this;
    return GlassTheme(
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceStrong: Color.lerp(surfaceStrong, other.surfaceStrong, t)!,
      border: Color.lerp(border, other.border, t)!,
      reflection: Color.lerp(reflection, other.reflection, t)!,
      blurSigma: blurSigma + (other.blurSigma - blurSigma) * t,
    );
  }
}
