import 'package:hiddify/core/preferences/preferences_provider.dart';
import 'package:hiddify/core/theme/app_color_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'color_theme_preferences.g.dart';

@Riverpod(keepAlive: true)
class ColorThemePreferences extends _$ColorThemePreferences {
  static const String _key = 'color_theme';

  @override
  AppColorTheme build() {
    final persisted =
        ref.watch(sharedPreferencesProvider).requireValue.getString(_key);
    return AppColorTheme.byName(persisted);
  }

  Future<void> changeColorTheme(AppColorTheme value) async {
    state = value;
    await ref
        .read(sharedPreferencesProvider)
        .requireValue
        .setString(_key, value.name);
  }
}
