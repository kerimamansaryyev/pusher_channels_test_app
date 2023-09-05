import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';

/// Possible Failures:
/// - [UnknownFailure]
@injectable
final class SaveSettingsRecords {
  final SettingsRepository _settingsRepository;

  const SaveSettingsRecords(
    this._settingsRepository,
  );

  Future<Either<Failure, void>> call({
    required String? themeName,
    required String? localeCode,
  }) async {
    if (themeName == null) {
      return const Right(null);
    }

    final themeNameSaveResultFailure =
        (await _settingsRepository.saveTheme(themeName)).tryGetLeft();

    if (localeCode == null) {
      return const Right(null);
    }

    final localeCodeSaveResultFailure =
        (await _settingsRepository.saveLocale(localeCode)).tryGetLeft();

    if (themeNameSaveResultFailure != null) {
      return Left(
        themeNameSaveResultFailure,
      );
    }

    if (localeCodeSaveResultFailure != null) {
      return Left(
        localeCodeSaveResultFailure,
      );
    }

    return const Right(null);
  }
}
