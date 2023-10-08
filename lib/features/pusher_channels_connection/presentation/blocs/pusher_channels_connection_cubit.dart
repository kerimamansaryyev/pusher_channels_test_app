import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/reset_pusher_channels_client.dart';

@injectable
final class PusherChannelsConnectionCubit
    extends Cubit<PusherChannelsConnectionState> {
  StreamSubscription? _connectionStreamSubs;
  final ConnectPusherChannelsClient _connectPusherChannelsClient;
  final ResetPusherChannelsClient _resetPusherChannelsClient;
  final ListenForPusherChannelsClientConnection
      _listenForPusherChannelsClientConnection;

  PusherChannelsConnectionCubit(
    this._connectPusherChannelsClient,
    this._resetPusherChannelsClient,
    this._listenForPusherChannelsClientConnection,
  ) : super(
          const PusherChannelsConnectionState(
            connectionResult: PusherChannelsConnectionPending(),
          ),
        );

  factory PusherChannelsConnectionCubit.fromEnvironment() =>
      serviceLocator<PusherChannelsConnectionCubit>();

  void connect() {
    _connectionStreamSubs = _listenForPusherChannelsClientConnection().listen(
      _onConnectionEvent,
    );
    _connectPusherChannelsClient();
  }

  void breakConnectionWithError(
    dynamic exception,
    StackTrace stackTrace,
  ) {
    _resetListeners();
    _onConnectionEvent(
      PusherChannelsConnectionFailed(
        exception: exception,
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  Future<void> close() {
    _connectionStreamSubs?.cancel();
    _resetPusherChannelsClient();
    return super.close();
  }

  void _onConnectionEvent(
    PusherChannelsConnectionResult connectionResult,
  ) {
    if (isClosed) {
      return;
    }
    emit(
      PusherChannelsConnectionState(
        connectionResult: connectionResult,
      ),
    );
  }

  void _resetListeners() {
    _connectionStreamSubs?.cancel();
    _connectionStreamSubs = null;
  }
}

final class PusherChannelsConnectionState {
  final PusherChannelsConnectionResult connectionResult;

  const PusherChannelsConnectionState({
    required this.connectionResult,
  });
}
