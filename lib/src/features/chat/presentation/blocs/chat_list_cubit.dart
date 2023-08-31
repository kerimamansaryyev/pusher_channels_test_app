import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/di/injection_container.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/use-cases/subscribe_and_listen_to_channel_events.dart';

@injectable
final class ChatListCubit extends Cubit<ChatListState> {
  StreamSubscription? _messagesStreamSubs;
  final List<PusherChannelsEventEntity> _messages = [];
  final SubscribeAndListenToChannelEvents _subscribeAndListenToChannelEvents;

  ChatListCubit(
    this._subscribeAndListenToChannelEvents,
  ) : super(
          const ChatListState(
            messages: [],
          ),
        );

  factory ChatListCubit.fromEnvironment() => serviceLocator<ChatListCubit>();

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
    emit(
      ChatListState(
        messages: _messages
          ..insert(
            0,
            pusherChannelsEventEntity,
          ),
      ),
    );
  }
}

final class ChatListState {
  final List<PusherChannelsEventEntity> messages;

  const ChatListState({
    required this.messages,
  });
}
