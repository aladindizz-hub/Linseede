import 'package:flutter/animation.dart';

class AnimationTokens {
  AnimationTokens._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration premium = Duration(milliseconds: 400);
  static const Duration hero = Duration(milliseconds: 800);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutQuart;
  static const Curve spring = Curves.elasticOut;
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.decelerate;

  static const int targetFps = 120;

  static const Duration pulse = Duration(milliseconds: 1800);
  static const Duration shimmer = Duration(milliseconds: 1500);
  static const Duration ringRotation = Duration(seconds: 6);
  static const Duration particleFloat = Duration(seconds: 4);
}
