import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/chat/data/constants/chat_constants.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/trigger_client_event_on_presence_channel.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

import '../../../mocks/dummy_failure.dart';
import '../../../mocks/test_mocks.mocks.dart';

final _getIt = GetIt.instance;

Future<void> _inject({
  required MockPusherChannelsConnectionRepository repository,
}) {
  _getIt.registerSingleton<PusherChannelsConnectionRepository>(repository);

  _getIt.registerFactory(
    () => TriggerClientEventOnPresenceChannel(
      _getIt(),
    ),
  );

  return _getIt.allReady();
}

void main() {
  group(
    'TriggerClientEventOnPresenceChannel use-case test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'TriggerClientEventOnPresenceChannel must refer to the method triggerClientEventOnPresenceChannel with constants in ChatConstants',
        () async {
          final repo = MockPusherChannelsConnectionRepository();
          provideDummyBuilder<
              Either<Failure<Exception>, PusherChannelsUserMessageEventEntity>>(
            (parent, invocation) => const Left(
              DummyFailure(),
            ),
          );
          when(
            repo.triggerClientEventOnPresenceChannel(
              message: anyNamed('message'),
              channelName: anyNamed('channelName'),
              eventName: anyNamed('eventName'),
            ),
          ).thenReturn(
            Right(
              MockPusherChannelsUserMessageEventEntity(),
            ),
          );
          await _inject(
            repository: repo,
          );
          final triggerClientEventOnPresenceChannel =
              _getIt<TriggerClientEventOnPresenceChannel>();

          const message = 'Hello';

          triggerClientEventOnPresenceChannel.call(
            message: message,
          );
          verify(
            repo.triggerClientEventOnPresenceChannel(
              message: message,
              channelName: ChatConstants.channelName,
              eventName: ChatConstants.triggeredEventName,
            ),
          );
        },
      );
    },
  );
}
