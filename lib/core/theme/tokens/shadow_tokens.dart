import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';

class ShadowTokens {
  ShadowTokens._();

  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x2E000000),
      blurRadius: 40,
      offset: Offset(0, 12),
    ),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color(0x47000000),
      blurRadius: 80,
      offset: Offset(0, 24),
    ),
  ];

  static const List<BoxShadow> premium = [
    BoxShadow(
      color: Color(0x59000000),
      blurRadius: 140,
      offset: Offset(0, 40),
    ),
  ];

  static const List<BoxShadow> glowBlue = [
    BoxShadow(
      color: Color(0x4D38BDF8),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> glowPurple = [
    BoxShadow(
      color: Color(0x478B5CF6),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> glowCyan = [
    BoxShadow(
      color: Color(0x4022D3EE),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> glowGreen = [
    BoxShadow(
      color: Color(0x404ADE80),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> glowGold = [
    BoxShadow(
      color: Color(0x47F5C26B),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> glowPink = [
    BoxShadow(
      color: Color(0x47F9A8D4),
      blurRadius: 60,
    ),
  ];

  static const List<BoxShadow> cardLight = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static List<BoxShadow> glowFromColor(Color color, {double opacity = 0.30, double blur = 60}) {
    return [
      BoxShadow(
        color: color.withOpacity(opacity),
        blurRadius: blur,
      ),
    ];
  }

  static const Color reflectionLayer = ColorTokens.glassWhite04;
}
