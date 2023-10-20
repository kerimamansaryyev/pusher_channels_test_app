import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/utils/mvp/app_model.dart';
import 'package:pusher_channels_test_app/features/settings/domain/stores/settings_store.dart';

@injectable
final class SettingsPageModel implements AppModel {
  final SettingsStoreCubit settingsStoreCubit;

  SettingsPageModel(
    this.settingsStoreCubit,
  );
}
