import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/di/injection_container.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/src/features/chat/domain/use-cases/subscribe_and_listen_to_presence_channel_events.dart';

@injectable
final class ChatListCubit extends Cubit<ChatListState> {
  StreamSubscription? _messagesStreamSubs;
  final List<PusherChannelsEventEntity> _messages = [];
  final SubscribeAndListenToPresenceChannelEvents
      _subscribeAndListenToChannelEvents;

  ChatListCubit(
    this._subscribeAndListenToChannelEvents,
  ) : super(
          const _WaitingForSubscription(),
        );

  factory ChatListCubit.fromEnvironment() => serviceLocator<ChatListCubit>();

  void resetToWaitingForSubscription() {
    emit(const _WaitingForSubscription());
  }

  @override
  Future<void> close() {
    _messagesStreamSubs?.cancel();
    return super.close();
  }

  void startListening() {
    _messagesStreamSubs?.cancel();
    _messagesStreamSubs = null;
    _messagesStreamSubs = _subscribeAndListenToChannelEvents().listen(
      _onEvent,
    );
  }

  void _onEvent(PusherChannelsEventEntity pusherChannelsEventEntity) {
    if (isClosed) {
      return;
    }

    if (state is _WaitingForSubscription &&
        pusherChannelsEventEntity is! PusherChannelsChatBeganEventModel) {
      _messages.add(pusherChannelsEventEntity);
      return;
    }

    emit(
      _Succeeded(
        messages: _messages
          ..add(
            pusherChannelsEventEntity,
          ),
      ),
    );
  }
}

extension ChatListStateExtension on ChatListState {
  T when<T>({
    required T Function(
      List<PusherChannelsEventEntity> messages,
    ) succeeded,
    required T Function() waitingForSubscription,
  }) =>
      switch (this) {
        _Succeeded(messages: final messages) => succeeded(messages),
        _WaitingForSubscription() => waitingForSubscription(),
      };
}

sealed class ChatListState {}

final class _Succeeded implements ChatListState {
  final List<PusherChannelsEventEntity> messages;

  const _Succeeded({
    required this.messages,
  });
}

final class _WaitingForSubscription implements ChatListState {
  const _WaitingForSubscription();
}
