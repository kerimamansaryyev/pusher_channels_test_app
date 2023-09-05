import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/chat/domain/use-cases/trigger_client_event_on_presence_channel.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';

@injectable
final class ChatMessageTriggerCubit extends Cubit<ChatMessageTriggerState> {
  final TriggerClientEventOnPresenceChannel
      _triggerClientEventOnPresenceChannel;

  ChatMessageTriggerCubit(
    this._triggerClientEventOnPresenceChannel,
  ) : super(
          const _Initial(),
        );

  factory ChatMessageTriggerCubit.fromEnvironment() =>
      serviceLocator<ChatMessageTriggerCubit>();

  void triggerClientEvent({
    required String message,
  }) {
    emit(
      _triggerClientEventOnPresenceChannel(
        message: message,
      ).fold(
        right: (result) => _Triggered(
          pusherChannelsUserMessageEventEntity: result,
        ),
        left: (failure) => _Failed(
          failure: failure,
        ),
      ),
    );
  }
}

sealed class ChatMessageTriggerState {}

extension ChatMessageSendStateExtension on ChatMessageTriggerState {
  T? whenOrNull<T>({
    T Function()? initial,
    T Function(
      PusherChannelsUserMessageEventEntity pusherChannelsUserMessageEventEntity,
    )? triggered,
    T Function(Failure)? failed,
  }) =>
      switch (this) {
        _Initial() => initial?.call(),
        _Triggered(
          pusherChannelsUserMessageEventEntity: final message,
        ) =>
          triggered?.call(message),
        _Failed(failure: final failure) => failed?.call(
            failure,
          )
      };
}

final class _Initial implements ChatMessageTriggerState {
  const _Initial();
}

final class _Triggered implements ChatMessageTriggerState {
  final PusherChannelsUserMessageEventEntity
      pusherChannelsUserMessageEventEntity;

  const _Triggered({
    required this.pusherChannelsUserMessageEventEntity,
  });
}

final class _Failed implements ChatMessageTriggerState {
  final Failure failure;

  const _Failed({
    required this.failure,
  });
}
