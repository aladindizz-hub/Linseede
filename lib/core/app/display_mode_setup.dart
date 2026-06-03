import 'package:flutter/foundation.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

Future<void> setupHighRefreshRate() async {
  if (kIsWeb) return;
  try {
    await FlutterDisplayMode.setHighRefreshRate();
  } catch (_) {
    // ignore: not supported on this device/platform
  }
}
