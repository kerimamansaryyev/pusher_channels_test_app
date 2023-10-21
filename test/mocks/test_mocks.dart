import 'package:mockito/annotations.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_locale.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_theme.dart';

@GenerateNiceMocks(
  [
    MockSpec<SettingsRepository>(),
    MockSpec<SaveLocale>(),
    MockSpec<SaveTheme>(),
    MockSpec<GetSettingsRecords>(),
    MockSpec<PusherChannelsConnectionRepository>(),
  ],
)
void main() {}
