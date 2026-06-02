import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/app_color_theme.dart';
import 'package:hiddify/core/theme/extensions/accent_theme.dart';
import 'package:hiddify/core/theme/extensions/glass_theme.dart';
import 'package:hiddify/core/theme/extensions/gradient_theme.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';
import 'package:hiddify/core/theme/theme_extensions.dart';
import 'package:hiddify/core/theme/tokens/color_tokens.dart';
import 'package:hiddify/core/theme/tokens/radius_tokens.dart';
import 'package:hiddify/core/theme/tokens/typography_tokens.dart';

class LinseedeTheme {
  LinseedeTheme._();

  static ThemeData build(AppColorTheme theme) {
    final surfaces = theme.surfaces;
    final accents = theme.accents;
    final gradients = theme.gradients;
    final glass = theme.glass;
    final isLight = theme.isLight;

    final colorScheme = ColorScheme(
      brightness: theme.brightness,
      primary: accents.primary,
      onPrimary: isLight ? Colors.white : ColorTokens.textPrimary,
      secondary: accents.secondary,
      onSecondary: isLight ? Colors.white : ColorTokens.textPrimary,
      tertiary: accents.tertiary,
      onTertiary: isLight ? Colors.white : ColorTokens.textPrimary,
      error: accents.danger,
      onError: Colors.white,
      surface: surfaces.elevated,
      onSurface: surfaces.textPrimary,
      surfaceContainerHighest: surfaces.panel,
      surfaceContainer: surfaces.elevated,
      surfaceContainerLow: surfaces.bgSecondary,
      surfaceContainerLowest: surfaces.bgPrimary,
      surfaceContainerHigh: surfaces.panel,
      onSurfaceVariant: surfaces.textSecondary,
      outline: glass.border,
      outlineVariant: glass.surface,
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: isLight ? ColorTokens.luxuryBgPrimary : ColorTokens.arcticBgPrimary,
      onInverseSurface: isLight ? ColorTokens.textPrimary : ColorTokens.textPrimaryLight,
      inversePrimary: accents.tertiary,
    );

    final textTheme = TypographyTokens.textThemeFor(
      surfaces.textPrimary,
      surfaces.textSecondary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: theme.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: surfaces.bgPrimary,
      canvasColor: surfaces.bgPrimary,
      dividerColor: glass.border,
      fontFamily: TypographyTokens.fontFamily,
      fontFamilyFallback: const [TypographyTokens.fontFamilyFallback],
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: IconThemeData(color: surfaces.textPrimary, size: 24),
      primaryIconTheme: IconThemeData(color: surfaces.textPrimary, size: 24),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: surfaces.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: TypographyTokens.semiBold,
        ),
        iconTheme: IconThemeData(color: surfaces.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surfaces.elevated,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: RadiusTokens.brLarge,
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaces.elevated,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: RadiusTokens.brLarge,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaces.elevated,
        modalBackgroundColor: surfaces.elevated,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: RadiusTokens.rLarge),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surfaces.panel,
        contentTextStyle: textTheme.bodyMedium,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: RadiusTokens.brMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: glass.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: RadiusTokens.brMedium,
          borderSide: BorderSide(color: glass.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: RadiusTokens.brMedium,
          borderSide: BorderSide(color: glass.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: RadiusTokens.brMedium,
          borderSide: BorderSide(color: accents.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: RadiusTokens.brMedium,
          borderSide: BorderSide(color: accents.danger, width: 1),
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: surfaces.textMuted),
        labelStyle: textTheme.bodyMedium?.copyWith(color: surfaces.textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accents.primary,
          foregroundColor: isLight ? Colors.white : ColorTokens.textPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: RadiusTokens.brMedium,
          ),
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: TypographyTokens.semiBold),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accents.primary,
          foregroundColor: isLight ? Colors.white : ColorTokens.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: RadiusTokens.brMedium,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accents.primary,
          side: BorderSide(color: glass.border, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: const RoundedRectangleBorder(
            borderRadius: RadiusTokens.brMedium,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accents.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: RadiusTokens.brSmall,
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: surfaces.textPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: RadiusTokens.brMedium,
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return surfaces.textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return accents.primary;
          return glass.surface;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return accents.primary;
          return Colors.transparent;
        }),
        side: BorderSide(color: glass.border, width: 1.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return accents.primary;
          return surfaces.textTertiary;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: accents.primary,
        inactiveTrackColor: glass.surface,
        thumbColor: accents.primary,
        overlayColor: accents.primary.withOpacity(0.12),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accents.primary,
        linearTrackColor: glass.surface,
        circularTrackColor: glass.surface,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: accents.primary,
        unselectedLabelColor: surfaces.textSecondary,
        indicatorColor: accents.primary,
        dividerColor: Colors.transparent,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.labelLarge,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaces.elevated,
        indicatorColor: accents.primary.withOpacity(0.16),
        labelTextStyle: WidgetStateProperty.all(textTheme.labelSmall),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: accents.primary);
          }
          return IconThemeData(color: surfaces.textSecondary);
        }),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surfaces.sidebar,
        selectedIconTheme: IconThemeData(color: accents.primary),
        unselectedIconTheme: IconThemeData(color: surfaces.textSecondary),
        selectedLabelTextStyle: textTheme.labelMedium?.copyWith(color: accents.primary),
        unselectedLabelTextStyle: textTheme.labelMedium?.copyWith(color: surfaces.textSecondary),
        indicatorColor: accents.primary.withOpacity(0.16),
        useIndicator: true,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: glass.surface,
        selectedColor: accents.primary.withOpacity(0.16),
        labelStyle: textTheme.labelSmall,
        side: BorderSide(color: glass.border),
        shape: const RoundedRectangleBorder(
          borderRadius: RadiusTokens.brSmall,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: glass.border,
        thickness: 1,
        space: 1,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: surfaces.panel,
          borderRadius: RadiusTokens.brSmall,
          border: Border.all(color: glass.border),
        ),
        textStyle: textTheme.labelSmall,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      splashColor: accents.primary.withOpacity(0.08),
      highlightColor: accents.primary.withOpacity(0.04),
      hoverColor: accents.primary.withOpacity(0.04),
      focusColor: accents.primary.withOpacity(0.12),
      extensions: <ThemeExtension<dynamic>>[
        surfaces,
        accents,
        gradients,
        glass,
        ConnectionButtonTheme(
          idleColor: surfaces.panel,
          connectedColor: accents.success,
        ),
      ],
    );
  }
}
