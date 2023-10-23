import 'package:mockito/annotations.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/reset_presence_channel_state.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/subscribe_and_listen_to_presence_channel_events.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/trigger_client_event_on_presence_channel.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_view.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/reset_pusher_channels_client.dart';
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
    MockSpec<PusherChannelsUserMessageEventEntity>(),
    MockSpec<PusherChannelsUserJoinedEventEntity>(),
    MockSpec<PusherChannelsChatBeganEventEntity>(),
    MockSpec<PusherChannelsUserLeftEventEntity>(),
    MockSpec<ChatPageView>(),
    MockSpec<ResetPusherChannelsClient>(),
    MockSpec<ListenForPusherChannelsClientConnection>(),
    MockSpec<ResetPresenceChannelState>(),
    MockSpec<ConnectPusherChannelsClient>(),
    MockSpec<TriggerClientEventOnPresenceChannel>(),
    MockSpec<SubscribeAndListenToPresenceChannelEvents>(),
  ],
)
void main() {}
