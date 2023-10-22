import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart';

import '../../../mocks/test_mocks.mocks.dart';

final _getIt = GetIt.instance;

MockPusherChannelsConnectionRepository _buildRepoWithConnectionEvents({
  required List<PusherChannelsConnectionResult> connectionStates,
}) {
  final repo = MockPusherChannelsConnectionRepository();
  when(repo.onConnectionChanged()).thenAnswer(
    (realInvocation) => Stream.fromIterable(
      connectionStates,
    ),
  );
  return repo;
}

Future<void> _inject({
  required PusherChannelsConnectionRepository repository,
}) {
  _getIt.registerSingleton<PusherChannelsConnectionRepository>(repository);
  _getIt.registerFactory(
    () => ListenForPusherChannelsClientConnection(
      repository,
    ),
  );
  return _getIt.allReady();
}

void main() {
  group(
    'ListenForPusherChannelsClientConnection use-case test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'ListenForPusherChannelsClientConnection must call onConnectionChanged of the repo',
        () async {
          final repo = _buildRepoWithConnectionEvents(
            connectionStates: const [],
          );
          await _inject(
            repository: repo,
          );
          final listenForConnectionChanges =
              _getIt<ListenForPusherChannelsClientConnection>();
          listenForConnectionChanges.call();
          verify(repo.onConnectionChanged());
        },
      );
      test(
        'ListenForPusherChannelsClientConnection receives events from the repo',
        () async {
          const expectedConnectionStatesOrder = [
            PusherChannelsConnectionPending(),
            PusherChannelsConnectionSucceeded(),
          ];
          final repo = _buildRepoWithConnectionEvents(
            connectionStates: expectedConnectionStatesOrder,
          );
          await _inject(
            repository: repo,
          );
          final listenForConnectionChanges =
              _getIt<ListenForPusherChannelsClientConnection>();
          unawaited(
            expectLater(
              listenForConnectionChanges.call(),
              emitsInOrder(
                [
                  ...expectedConnectionStatesOrder.map(
                    (e) => equals(e),
                  ),
                  emitsDone,
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
