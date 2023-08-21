import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SettingsPreferences {
  FutureOr<String?> getThemeName();
  FutureOr<String?> getLocaleCode();

  FutureOr<void> saveThemeName(String themeName);
  FutureOr<void> saveLocaleCode(String localeCode);
}

@Injectable(
  as: SettingsPreferences,
)
final class SettingsPreferencesImpl implements SettingsPreferences {
  static const _preferencesLocaleKey = 'app_user_locale';
  static const _preferencesThemeKey = 'app_user_theme';

  final SharedPreferences _preferences;

  const SettingsPreferencesImpl(
    this._preferences,
  );

  @override
  FutureOr<String?> getLocaleCode() {
    return _preferences.getString(_preferencesLocaleKey);
  }

  @override
  FutureOr<String?> getThemeName() {
    return _preferences.getString(_preferencesThemeKey);
  }

  @override
  FutureOr<void> saveLocaleCode(String localeCode) {
    _preferences.setString(
      _preferencesLocaleKey,
      localeCode,
    );
  }

  @override
  FutureOr<void> saveThemeName(String themeName) {
    _preferences.setString(
      _preferencesThemeKey,
      themeName,
    );
  }
}
