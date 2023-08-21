import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/core/domain/failure.dart';
import 'package:pusher_channels_test_app/src/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/src/features/settings/data/storages/settings_preferences.dart';
import 'package:pusher_channels_test_app/src/features/settings/domain/repositories/settings_repository.dart';

@Injectable(
  as: SettingsRepository,
)
final class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsPreferences _settingsPreferences;

  const SettingsRepositoryImpl(
    this._settingsPreferences,
  );

  @override
  Future<Either<Failure<Exception>, String?>> getLocaleCode() async {
    try {
      return Right(
        await _settingsPreferences.getLocaleCode(),
      );
    } on Exception catch (e, t) {
      return Left(
        UnknownFailure(
          exception: e,
          stackTrace: t,
        ),
      );
    }
  }

  @override
  Future<Either<Failure<Exception>, String?>> getThemeName() async {
    try {
      return Right(
        await _settingsPreferences.getThemeName(),
      );
    } on Exception catch (e, t) {
      return Left(
        UnknownFailure(
          exception: e,
          stackTrace: t,
        ),
      );
    }
  }

  @override
  Future<Either<Failure<Exception>, void>> saveLocale(String localeCode) async {
    try {
      await _settingsPreferences.saveLocaleCode(
        localeCode,
      );
      return const Right(
        null,
      );
    } on Exception catch (e, t) {
      return Left(
        UnknownFailure(
          exception: e,
          stackTrace: t,
        ),
      );
    }
  }

  @override
  Future<Either<Failure<Exception>, void>> saveTheme(String themeName) async {
    try {
      await _settingsPreferences.saveThemeName(
        themeName,
      );
      return const Right(
        null,
      );
    } on Exception catch (e, t) {
      return Left(
        UnknownFailure(
          exception: e,
          stackTrace: t,
        ),
      );
    }
  }
}
