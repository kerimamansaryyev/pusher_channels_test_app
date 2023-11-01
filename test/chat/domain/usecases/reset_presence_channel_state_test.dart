import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/features/chat/data/constants/chat_constants.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/reset_presence_channel_state.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import '../../../mocks/test_mocks.mocks.dart';

final _getIt = GetIt.instance;

Future<void> _inject({
  required MockPusherChannelsConnectionRepository repository,
}) {
  _getIt.registerSingleton<PusherChannelsConnectionRepository>(repository);

  _getIt.registerFactory(
    () => ResetPresenceChannelState(
      _getIt(),
    ),
  );

  return _getIt.allReady();
}

void main() {
  group(
    'ResetPresenceChannelState use-case test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'ResetPresenceChannelState must refer to the method resetPresenceChannelState with constants in ChatConstants',
        () async {
          final repo = MockPusherChannelsConnectionRepository();
          when(
            repo.resetPresenceChannelState(
              channelName: anyNamed(
                'channelName',
              ),
            ),
          ).thenReturn(
            null,
          );
          await _inject(
            repository: repo,
          );
          final resetPresenceChannelState = _getIt<ResetPresenceChannelState>();
          resetPresenceChannelState.call();
          verify(
            repo.resetPresenceChannelState(
              channelName: ChatConstants.channelName,
            ),
          ).called(1);
        },
      );
    },
  );
}
