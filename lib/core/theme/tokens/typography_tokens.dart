import 'package:flutter/material.dart';

class TypographyTokens {
  TypographyTokens._();

  static const String fontFamily = 'Inter';
  static const String fontFamilyFallback = 'SF Pro Display';

  static const double displayXl = 64.0;
  static const double displayL = 48.0;
  static const double headingXl = 36.0;
  static const double headingL = 28.0;
  static const double headingM = 24.0;
  static const double bodyL = 18.0;
  static const double bodyM = 16.0;
  static const double bodyS = 14.0;
  static const double caption = 12.0;

  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight light = FontWeight.w300;

  static TextTheme textThemeFor(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(fontSize: displayXl, fontWeight: extraBold, color: primary, letterSpacing: -1.5, height: 1.05),
      displayMedium: TextStyle(fontSize: displayL, fontWeight: bold, color: primary, letterSpacing: -1.0, height: 1.1),
      displaySmall: TextStyle(fontSize: headingXl, fontWeight: bold, color: primary, letterSpacing: -0.5, height: 1.15),
      headlineLarge: TextStyle(fontSize: headingL, fontWeight: bold, color: primary, letterSpacing: -0.4, height: 1.2),
      headlineMedium: TextStyle(fontSize: headingM, fontWeight: semiBold, color: primary, letterSpacing: -0.3, height: 1.25),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: semiBold, color: primary, letterSpacing: -0.2, height: 1.3),
      titleLarge: TextStyle(fontSize: bodyL, fontWeight: semiBold, color: primary, height: 1.35),
      titleMedium: TextStyle(fontSize: bodyM, fontWeight: semiBold, color: primary, height: 1.4),
      titleSmall: TextStyle(fontSize: bodyS, fontWeight: semiBold, color: primary, height: 1.4),
      bodyLarge: TextStyle(fontSize: bodyL, fontWeight: regular, color: primary, height: 1.5),
      bodyMedium: TextStyle(fontSize: bodyM, fontWeight: regular, color: primary, height: 1.5),
      bodySmall: TextStyle(fontSize: bodyS, fontWeight: regular, color: secondary, height: 1.5),
      labelLarge: TextStyle(fontSize: bodyM, fontWeight: medium, color: primary, letterSpacing: 0.1, height: 1.4),
      labelMedium: TextStyle(fontSize: bodyS, fontWeight: medium, color: secondary, letterSpacing: 0.2, height: 1.4),
      labelSmall: TextStyle(fontSize: caption, fontWeight: medium, color: secondary, letterSpacing: 0.4, height: 1.4),
    );
  }
}
