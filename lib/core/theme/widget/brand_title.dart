import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';

class BrandTitle extends StatelessWidget {
  const BrandTitle({
    super.key,
    this.fontSize = 22,
    this.firstPart = 'Linseede',
    this.secondPart = 'VPN',
  });

  final double fontSize;
  final String firstPart;
  final String secondPart;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).extensions[AccentTheme]! as AccentTheme;
    final surface = Theme.of(context).extensions[SurfaceTheme]! as SurfaceTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          firstPart,
          style: TextStyle(
            fontFamily: TypographyTokens.fontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            color: surface.textPrimary,
          ),
        ),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (rect) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [accent.primary, accent.secondary],
          ).createShader(rect),
          child: Text(
            secondPart,
            style: TextStyle(
              fontFamily: TypographyTokens.fontFamily,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
