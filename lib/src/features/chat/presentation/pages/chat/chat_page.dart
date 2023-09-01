import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_typography.dart';
import 'package:pusher_channels_test_app/src/features/chat/presentation/blocs/chat_list_cubit.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart';
import 'package:pusher_channels_test_app/src/localization/extensions.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final PusherChannelsConnectionCubit _pusherChannelsConnectionCubit =
      PusherChannelsConnectionCubit.fromEnvironment();
  final ChatListCubit _chatListCubit = ChatListCubit.fromEnvironment();

  @override
  void initState() {
    _pusherChannelsConnectionCubit.connect();
    super.initState();
  }

  @override
  void dispose() {
    _pusherChannelsConnectionCubit.close();
    _chatListCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          context.translation.chatRoom,
          textScaleFactor: 1,
        ),
      ),
      child: Builder(
        builder: (context) {
          return MultiBlocListener(
            listeners: [
              BlocListener<PusherChannelsConnectionCubit,
                  PusherChannelsConnectionState>(
                bloc: _pusherChannelsConnectionCubit,
                listener: (context, state) {
                  if (state.connectionResult
                      case PusherChannelsConnectionSucceeded()) {
                    _chatListCubit.startListening();
                  }
                },
              ),
            ],
            child: BlocBuilder<PusherChannelsConnectionCubit,
                PusherChannelsConnectionState>(
              bloc: _pusherChannelsConnectionCubit,
              builder: (context, connectionState) =>
                  BlocBuilder<ChatListCubit, ChatListState>(
                bloc: _chatListCubit,
                builder: (context, chatListState) =>
                    switch (connectionState.connectionResult) {
                  PusherChannelsConnectionSucceeded() => CustomScrollView(
                      reverse: true,
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(
                            top: AppTheme.navBarPadding(context),
                          ),
                          sliver: SliverList.builder(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppTheme.sectionsDividingSpace,
                              ),
                              child: switch (chatListState.messages[index]) {
                                PusherChannelsChatBeganEventModel() ||
                                PusherChannelsUserJoinedEventModel() ||
                                PusherChannelsUserLeftEventModel() =>
                                  _EventNotification(
                                    eventEntity: chatListState.messages[index],
                                  ),
                              },
                            ),
                            itemCount: chatListState.messages.length,
                          ),
                        ),
                      ],
                    ),
                  PusherChannelsConnectionPending() => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  PusherChannelsConnectionFailed(exception: final exception) =>
                    Center(
                      child: Text(
                        context.translation.errorOccurred(
                          exception.runtimeType.toString(),
                        ),
                      ),
                    ),
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EventNotification extends StatelessWidget {
  final PusherChannelsEventEntity eventEntity;

  const _EventNotification({
    required this.eventEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              switch (eventEntity) {
                PusherChannelsChatBeganEventModel(
                  myUserId: final myUserId,
                ) =>
                  context.translation.chatBegan(
                    myUserId.toString(),
                  ),
                PusherChannelsUserJoinedEventModel(userId: final userId) =>
                  context.translation.userJoined(
                    userId.toString(),
                  ),
                PusherChannelsUserLeftEventModel(userId: final userId) =>
                  context.translation.userLeft(
                    userId.toString(),
                  ),
                _ => '',
              },
              style: AppTypographies.b3.style(context).copyWith(
                    color: CupertinoDynamicColor.resolve(
                      CupertinoColors.secondaryLabel,
                      context,
                    ),
                  ),
            ),
          ),
        )
      ],
    );
  }
}
