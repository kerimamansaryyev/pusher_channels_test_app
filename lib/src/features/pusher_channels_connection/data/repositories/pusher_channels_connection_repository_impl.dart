import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/data/constants/pusher_channels_connection_constants.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@LazySingleton(
  as: PusherChannelsConnectionRepository,
)
final class PusherChannelsConnectionRepositoryImpl
    implements PusherChannelsConnectionRepository {
  StreamSubscription? _clientConnectionStreamSubs;
  PusherChannelsClient? _pusherChannelsClient;
  final StreamController<PusherChannelsConnectionResult>
      _connectionStreamController = StreamController.broadcast();

  PusherChannelsConnectionRepositoryImpl() {
    resetToDefaults();
  }

  @override
  void connect() {
    _pusherChannelsClient?.connect();
  }

  @override
  void resetToDefaults() {
    _clientConnectionStreamSubs?.cancel();
    _pusherChannelsClient?.dispose();
    _clientConnectionStreamSubs = null;
    _pusherChannelsClient = null;
    final client = _pusherChannelsClient = PusherChannelsClient.websocket(
      options: PusherChannelsConnectionConstants.pusherChannelsOptions,
      connectionErrorHandler: (exception, trace, _) =>
          _onConnectionError(exception, trace),
    );
    _clientConnectionStreamSubs =
        client.lifecycleStream.listen(_onClientConnectionStreamEvent);
  }

  @override
  Stream<PusherChannelsConnectionResult> onConnectionChanged() =>
      _connectionStreamController.stream;

  void _onClientConnectionStreamEvent(
    PusherChannelsClientLifeCycleState lifeCycleState,
  ) {
    switch (lifeCycleState) {
      case PusherChannelsClientLifeCycleState.pendingConnection:
        _connectionStreamController.add(
          const PusherChannelsConnectionPending(),
        );
        return;
      case PusherChannelsClientLifeCycleState.establishedConnection:
        _connectionStreamController.add(
          const PusherChannelsConnectionSucceeded(),
        );
      default:
        return;
    }
  }

  void _onConnectionError(
    dynamic exception,
    StackTrace trace,
  ) =>
      _safelyAddConnectionResultToController(
        PusherChannelsConnectionFailed(
          exception: exception,
          stackTrace: trace,
        ),
      );

  void _safelyAddConnectionResultToController(
    PusherChannelsConnectionResult event,
  ) {
    if (!_connectionStreamController.isClosed) {
      _connectionStreamController.add(
        event,
      );
    }
  }
}
