import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/extensions/gradient_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';

enum AppColorTheme {
  luxuryDark,
  midnightAurora,
  royalObsidian,
  arcticGlass,
  sakuraMist,
  carbonPro;

  String get displayName => switch (this) {
        luxuryDark => 'Luxury Dark',
        midnightAurora => 'Midnight Aurora',
        royalObsidian => 'Royal Obsidian',
        arcticGlass => 'Arctic Glass',
        sakuraMist => 'Sakura Mist',
        carbonPro => 'Carbon Pro',
      };

  String get emoji => switch (this) {
        luxuryDark => '🌌',
        midnightAurora => '🌅',
        royalObsidian => '🔮',
        arcticGlass => '❄️',
        sakuraMist => '🌸',
        carbonPro => '⚡',
      };

  String get tagline => switch (this) {
        luxuryDark => 'Electric Blue · Neon Purple',
        midnightAurora => 'Aurora Green · Teal · Violet',
        royalObsidian => 'Royal Gold · Magenta',
        arcticGlass => 'Sky Blue · Ice Cyan',
        sakuraMist => 'Sakura Pink · Coral',
        carbonPro => 'Pure White · Electric Lime',
      };

  Brightness get brightness => switch (this) {
        arcticGlass => Brightness.light,
        _ => Brightness.dark,
      };

  bool get isLight => brightness == Brightness.light;

  SurfaceTheme get surfaces => switch (this) {
        luxuryDark => SurfaceTheme.luxury,
        midnightAurora => SurfaceTheme.aurora,
        royalObsidian => SurfaceTheme.royal,
        arcticGlass => SurfaceTheme.arctic,
        sakuraMist => SurfaceTheme.sakura,
        carbonPro => SurfaceTheme.carbon,
      };

  AccentTheme get accents => switch (this) {
        luxuryDark => AccentTheme.luxury,
        midnightAurora => AccentTheme.aurora,
        royalObsidian => AccentTheme.royal,
        arcticGlass => AccentTheme.arctic,
        sakuraMist => AccentTheme.sakura,
        carbonPro => AccentTheme.carbon,
      };

  GradientTheme get gradients => switch (this) {
        luxuryDark => GradientTheme.luxury,
        midnightAurora => GradientTheme.auroraTheme,
        royalObsidian => GradientTheme.royal,
        arcticGlass => GradientTheme.arctic,
        sakuraMist => GradientTheme.sakura,
        carbonPro => GradientTheme.carbon,
      };

  GlassTheme get glass => isLight ? GlassTheme.light : GlassTheme.dark;

  static AppColorTheme byName(String? name) {
    if (name == null) return AppColorTheme.luxuryDark;
    return AppColorTheme.values.firstWhere(
      (e) => e.name == name,
      orElse: () => AppColorTheme.luxuryDark,
    );
  }
}
