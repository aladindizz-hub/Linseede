import 'package:flutter/material.dart';

class RadiusTokens {
  RadiusTokens._();

  static const double small = 14.0;
  static const double medium = 22.0;
  static const double large = 30.0;
  static const double extraLarge = 38.0;
  static const double circular = 999.0;

  static const Radius rSmall = Radius.circular(small);
  static const Radius rMedium = Radius.circular(medium);
  static const Radius rLarge = Radius.circular(large);
  static const Radius rExtraLarge = Radius.circular(extraLarge);
  static const Radius rCircular = Radius.circular(circular);

  static const BorderRadius brSmall = BorderRadius.all(rSmall);
  static const BorderRadius brMedium = BorderRadius.all(rMedium);
  static const BorderRadius brLarge = BorderRadius.all(rLarge);
  static const BorderRadius brExtraLarge = BorderRadius.all(rExtraLarge);
  static const BorderRadius brCircular = BorderRadius.all(rCircular);
}
