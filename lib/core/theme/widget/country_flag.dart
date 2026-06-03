import 'package:flutter/material.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({
    super.key,
    required this.countryCode,
    this.size = 28,
    this.fontSize,
  });

  final String countryCode;
  final double size;
  final double? fontSize;

  String _toEmoji(String code) {
    final upper = code.toUpperCase();
    if (upper.length != 2) return '🏳';
    final first = upper.codeUnitAt(0);
    final second = upper.codeUnitAt(1);
    if (first < 0x41 || first > 0x5A || second < 0x41 || second > 0x5A) return '🏳';
    final base = 0x1F1E6 - 0x41;
    return String.fromCharCodes([base + first, base + second]);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text(
          _toEmoji(countryCode),
          style: TextStyle(
            fontSize: fontSize ?? size * 0.9,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
