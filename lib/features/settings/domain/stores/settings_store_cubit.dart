import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_locale.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_theme.dart';
import 'package:pusher_channels_test_app/localization/localization_service.dart';

@singleton
final class SettingsStoreCubit extends Cubit<SettingsStoreState> {
  final SaveLocale _saveLocale;
  final SaveTheme _saveTheme;

  SettingsStoreCubit._(
    super.initialState,
    this._saveLocale,
    this._saveTheme,
  );

  factory SettingsStoreCubit.fromEnvironment() =>
      serviceLocator<SettingsStoreCubit>();

  void toggleTheme(bool isDark) {
    final theme = isDark ? const AppTheme.dark() : const AppTheme.light();

    _saveTheme(
      themeName: theme.name,
    );

    emit(
      state.copyWith(
        theme: theme,
      ),
    );
  }

  void chooseLanguage(Locale locale) {
    _saveLocale(
      localeCode: locale.languageCode,
    );

    emit(
      state.copyWith(
        locale: locale,
      ),
    );
  }

  @FactoryMethod(
    preResolve: true,
  )
  static Future<SettingsStoreCubit> internal(
    GetSettingsRecords getSettingsRecords,
    SaveLocale saveLocale,
    SaveTheme saveTheme,
  ) async {
    final result = await getSettingsRecords();
    final record = result.tryGetRight();
    final theme = record?.$1;
    final locale = record?.$2;

    return SettingsStoreCubit._(
      SettingsStoreState(
        locale: locale ?? LocalizationService.fallbackLocale,
        theme: theme,
      ),
      saveLocale,
      saveTheme,
    );
  }
}

final class SettingsStoreState {
  final Locale locale;
  final AppTheme? theme;

  const SettingsStoreState({
    required this.locale,
    required this.theme,
  });

  @override
  int get hashCode => Object.hashAllUnordered(
        [
          locale,
          theme,
        ],
      );

  SettingsStoreState copyWith({
    Locale? locale,
    AppTheme? theme,
  }) {
    return SettingsStoreState(
      locale: locale ?? this.locale,
      theme: theme ?? this.theme,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is SettingsStoreState &&
      runtimeType == other.runtimeType &&
      locale == other.locale &&
      theme == other.theme;
}
