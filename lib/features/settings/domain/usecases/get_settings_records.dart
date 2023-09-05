import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';

typedef SettingsRecord = (AppTheme?, Locale? locale);

/// Possible Failures:
/// - [UnknownFailure]
@injectable
final class GetSettingsRecords {
  final SettingsRepository _settingsRepository;

  const GetSettingsRecords(this._settingsRepository);

  Future<Either<Failure, SettingsRecord>> call() async {
    final themeNameResult = await _settingsRepository.getThemeName();
    final localeCodeResult = await _settingsRepository.getLocaleCode();

    final themeFailure = themeNameResult.tryGetLeft();
    final localeFailure = localeCodeResult.tryGetLeft();

    if (themeFailure != null) {
      return Left(themeFailure);
    }
    if (localeFailure != null) {
      return Left(localeFailure);
    }

    final themeName = themeNameResult.tryGetRight();
    final locale = localeCodeResult.tryGetRight();

    return Right(
      (
        themeName == null ? null : AppTheme.findByName(themeName),
        locale == null ? null : Locale(locale),
      ),
    );
  }
}
