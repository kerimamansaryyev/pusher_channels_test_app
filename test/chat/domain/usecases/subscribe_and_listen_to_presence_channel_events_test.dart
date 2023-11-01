import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/features/chat/data/constants/chat_constants.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/subscribe_and_listen_to_presence_channel_events.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import '../../../mocks/test_mocks.mocks.dart';

final _getIt = GetIt.instance;

Future<void> _inject({
  required MockPusherChannelsConnectionRepository repository,
}) {
  _getIt.registerSingleton<PusherChannelsConnectionRepository>(repository);

  _getIt.registerFactory(
    () => SubscribeAndListenToPresenceChannelEvents(
      _getIt(),
    ),
  );

  return _getIt.allReady();
}

void main() {
  group(
    'SubscribeAndListenToPresenceChannelEvents use-case test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'SubscribeAndListenToPresenceChannelEvents must refer to the method resetPresenceChannelState with constants in ChatConstants',
        () async {
          final repo = MockPusherChannelsConnectionRepository();
          when(
            repo.onPresenceChannelEvent(
              channelName: anyNamed('channelName'),
              eventNameToBind: anyNamed('eventNameToBind'),
            ),
          ).thenAnswer(
            (realInvocation) => const Stream.empty(),
          );
          await _inject(
            repository: repo,
          );
          final subscribeAndListenToPresenceChannelEvents =
              _getIt<SubscribeAndListenToPresenceChannelEvents>();
          subscribeAndListenToPresenceChannelEvents.call();
          verify(
            repo.onPresenceChannelEvent(
              channelName: ChatConstants.channelName,
              eventNameToBind: null,
            ),
          ).called(1);
        },
      );
      test(
        'SubscribeAndListenToPresenceChannelEvents fires events retrieved from the repos .onPresenceChannelEvent method\'s stream',
        () async {
          final repo = MockPusherChannelsConnectionRepository();
          final expectedEvents = <PusherChannelsEventEntity>[
            MockPusherChannelsChatBeganEventEntity(),
            MockPusherChannelsUserJoinedEventEntity(),
            MockPusherChannelsUserMessageEventEntity(),
            MockPusherChannelsUserLeftEventEntity(),
          ];
          when(
            repo.onPresenceChannelEvent(
              channelName: anyNamed('channelName'),
              eventNameToBind: anyNamed('eventNameToBind'),
            ),
          ).thenAnswer(
            (realInvocation) => Stream.fromIterable(expectedEvents),
          );
          await _inject(
            repository: repo,
          );
          final subscribeAndListenToPresenceChannelEvents =
              _getIt<SubscribeAndListenToPresenceChannelEvents>();
          unawaited(
            expectLater(
              subscribeAndListenToPresenceChannelEvents.call(),
              emitsInOrder(
                expectedEvents.map(
                  (e) => equals(e),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
