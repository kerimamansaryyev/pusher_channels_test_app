import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/utils/mvp/app_model.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_list_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_message_trigger_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_new_messages_button_visibility.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart';

@injectable
final class ChatPageModel implements AppModel {
  final ChatNewMessagesButtonVisibilityCubit
      chatNewMessagesButtonVisibilityCubit;

  final PusherChannelsConnectionCubit pusherChannelsConnectionCubit;
  final ChatListCubit chatListCubit;
  final ChatMessageTriggerCubit chatMessageTriggerCubit;

  ChatPageModel({
    required this.chatNewMessagesButtonVisibilityCubit,
    required this.pusherChannelsConnectionCubit,
    required this.chatListCubit,
    required this.chatMessageTriggerCubit,
  });
}
