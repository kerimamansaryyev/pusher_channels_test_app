import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart';

import '../../../mocks/test_mocks.mocks.dart';

final _getIt = GetIt.instance;

Future<void> _inject({
  required PusherChannelsConnectionRepository repository,
}) {
  _getIt.registerSingleton<PusherChannelsConnectionRepository>(repository);
  _getIt.registerFactory(
    () => ConnectPusherChannelsClient(
      repository,
    ),
  );
  return _getIt.allReady();
}

void main() {
  group(
    'ConnectPusherChannelsClient use-case test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'ConnectPusherChannelsClient must call resetToDefaults and then connect method',
        () async {
          final repo = MockPusherChannelsConnectionRepository();
          when(repo.connect()).thenReturn(null);
          when(repo.resetToDefaults()).thenReturn(null);
          await _inject(repository: repo);
          final connectPusherChannelsClient =
              _getIt<ConnectPusherChannelsClient>();
          connectPusherChannelsClient.call();
          verifyInOrder(
            [
              repo.resetToDefaults(),
              repo.connect(),
            ],
          );
        },
      );
    },
  );
}
