import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/usecases/reset_pusher_channels_client.dart';

import '../../../mocks/test_mocks.mocks.dart';

final _getIt = GetIt.instance;

Future<void> _inject({
  required PusherChannelsConnectionRepository repository,
}) {
  _getIt.registerSingleton<PusherChannelsConnectionRepository>(repository);
  _getIt.registerFactory(
    () => ResetPusherChannelsClient(
      repository,
    ),
  );
  return _getIt.allReady();
}

void main() {
  group(
    'ResetPusherChannelsClient use-case test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'ResetPusherChannelsClient must call resetToDefaults of the repo',
        () async {
          final repo = MockPusherChannelsConnectionRepository();
          when(repo.resetToDefaults()).thenReturn(null);
          await _inject(repository: repo);
          final resetPusherChannelsClient = _getIt<ResetPusherChannelsClient>();
          resetPusherChannelsClient.call();
          verify(repo.resetToDefaults());
        },
      );
    },
  );
}
