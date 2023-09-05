import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';

abstract interface class SettingsRepository {
  Future<Either<Failure, String?>> getThemeName();
  Future<Either<Failure, String?>> getLocaleCode();
  Future<Either<Failure, void>> saveTheme(String themeName);
  Future<Either<Failure, void>> saveLocale(String localeCode);
}
