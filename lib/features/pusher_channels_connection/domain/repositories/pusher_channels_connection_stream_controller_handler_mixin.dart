import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

abstract mixin class PusherChannelsConnectionStreamControllerHandlerMixin
    implements PusherChannelsConnectionRepository {
  @protected
  final StreamController<PusherChannelsConnectionResult>
      connectionStreamController = StreamController.broadcast();

  @override
  Stream<PusherChannelsConnectionResult> onConnectionChanged() =>
      connectionStreamController.stream;

  @protected
  void fireConnectionResultEvent(
    PusherChannelsConnectionResult event,
  ) {
    if (!connectionStreamController.isClosed) {
      connectionStreamController.add(
        event,
      );
    }
  }

  @protected
  void fireConnectionErrorEvent(
    dynamic exception,
    StackTrace trace,
  ) =>
      fireConnectionResultEvent(
        PusherChannelsConnectionFailed(
          exception: exception,
          stackTrace: trace,
        ),
      );
}
