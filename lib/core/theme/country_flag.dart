import 'package:flutter/material.dart';
import 'package:hiddify/core/theme/extensions/surface_theme.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({
    super.key,
    required this.countryCode,
    this.size = 44,
    this.borderRadius = 10,
  });

  final String? countryCode;
  final double size;
  final double borderRadius;

  static String? _toEmoji(String? code) {
    if (code == null) return null;
    final upper = code.trim().toUpperCase();
    if (upper.length != 2) return null;
    final a = upper.codeUnitAt(0);
    final b = upper.codeUnitAt(1);
    if (a < 0x41 || a > 0x5A || b < 0x41 || b > 0x5A) return null;
    final base = 0x1F1E6;
    return String.fromCharCodes([base + (a - 0x41), base + (b - 0x41)]);
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).extension<SurfaceTheme>()!;
    final emoji = _toEmoji(countryCode);
    final br = BorderRadius.circular(borderRadius);

    return ClipRRect(
      borderRadius: br,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: surface.elevated,
          borderRadius: br,
        ),
        alignment: Alignment.center,
        child: emoji != null
            ? FittedBox(
                fit: BoxFit.cover,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    emoji,
                    style: TextStyle(fontSize: size * 0.9, height: 1),
                  ),
                ),
              )
            : Icon(
                Icons.public_rounded,
                size: size * 0.5,
                color: surface.textTertiary,
              ),
      ),
    );
  }
}
