import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/utils/mvp/app_presenter.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_list_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_message_trigger_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_new_messages_button_visibility.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_model.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_view.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/message_not_triggered_failure.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart';
import 'package:pusher_channels_test_app/localization/extensions.dart';

@injectable
final class ChatPagePresenter
    extends AppPresenter<ChatPageView, ChatPageModel> {
  static const _subsWaitingTimeoutDuration = Duration(
    seconds: 5,
  );

  @override
  final ChatPageModel model;

  ChatPagePresenter(
    this.model,
  );

  factory ChatPagePresenter.fromEnvironment() =>
      serviceLocator<ChatPagePresenter>();

  BlocBase<PusherChannelsConnectionState>
      get readPusherChannelsConnectionCubit =>
          model.pusherChannelsConnectionCubit;

  BlocBase<ChatListState> get readChatListCubit => model.chatListCubit;

  BlocBase<ChatMessageTriggerState> get readChatMessageTriggerCubit =>
      model.chatMessageTriggerCubit;

  BlocBase<ChatNewMessagesButtonVisibilityState>
      get readChatNewMessagesButtonVisibilityCubit =>
          model.chatNewMessagesButtonVisibilityCubit;

  void installConnection() {
    model.pusherChannelsConnectionCubit.connect();
  }

  void setButtonInvisible() {
    model.chatNewMessagesButtonVisibilityCubit.setInvisible();
  }

  void triggerMessage(String message) {
    model.chatMessageTriggerCubit.triggerClientEvent(
      message: message,
    );
  }

  @override
  void dispose() {
    super.dispose();
    model.pusherChannelsConnectionCubit.close();
    model.chatListCubit.close();
    model.chatMessageTriggerCubit.close();
    model.chatNewMessagesButtonVisibilityCubit.close();
  }

  @override
  MultiBlocListener buildMultiBlocListener(BuildContext context, Widget child) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChatListCubit, ChatListState>(
          bloc: model.chatListCubit,
          listener: (context, state) => _whenGotNewMessages(state),
        ),
        BlocListener<ChatMessageTriggerCubit, ChatMessageTriggerState>(
          bloc: model.chatMessageTriggerCubit,
          listener: (context, state) => state.whenOrNull(
            triggered: (message) {
              model.chatListCubit.pushOwnMessage(message);
              view?.scrollToBottom();
            },
            failed: (failure) {
              if (failure case MessageNotTriggeredFailure()) {
                view?.showMessageNotTriggeredError(
                  title: context.translation.error,
                  description: context.translation.messageNotTriggered,
                );
              }
            },
          ),
        ),
        BlocListener<PusherChannelsConnectionCubit,
            PusherChannelsConnectionState>(
          bloc: model.pusherChannelsConnectionCubit,
          listener: (context, state) => _onConnectionChanged(
            state,
          ),
        ),
      ],
      child: child,
    );
  }

  void _checkIfWaitingLongForSubscription() async {
    try {
      await Future.delayed(_subsWaitingTimeoutDuration);
      model.chatListCubit.state.when(
        succeeded: (_) {
          return;
        },
        waitingForSubscription: () => throw TimeoutException(null),
      );
    } on TimeoutException catch (exception, stackTrace) {
      model.pusherChannelsConnectionCubit.breakConnectionWithError(
        exception,
        stackTrace,
      );
    }
  }

  void _onConnectionChanged(PusherChannelsConnectionState connectionState) {
    if (connectionState.connectionResult
        case PusherChannelsConnectionSucceeded()) {
      model.chatListCubit.startListening();
      _checkIfWaitingLongForSubscription();
    } else if (connectionState.connectionResult
        case PusherChannelsConnectionPending()) {
      model.chatListCubit.resetToWaitingForSubscription();
    }
  }

  void _whenGotNewMessages(ChatListState chatListState) {
    chatListState.when(
      succeeded: (messages) {
        if (messages.isEmpty) {
          return;
        }
        final newestMessage = messages.last;

        if (newestMessage is! PusherChannelsUserMessageEventEntity ||
            newestMessage.isMyMessage) {
          return;
        }

        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          if (view?.canShowNewMessagesButton ?? false) {
            model.chatNewMessagesButtonVisibilityCubit.setVisible();
          }
        });
      },
      waitingForSubscription: () => null,
    );
  }
}
