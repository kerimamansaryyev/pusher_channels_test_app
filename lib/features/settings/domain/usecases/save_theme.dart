import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';

@injectable
class SaveTheme {
  final SettingsRepository _settingsRepository;

  const SaveTheme(
    this._settingsRepository,
  );

  Future<Either<Failure, void>> call({
    required String themeName,
  }) =>
      _settingsRepository.saveTheme(themeName);
}
