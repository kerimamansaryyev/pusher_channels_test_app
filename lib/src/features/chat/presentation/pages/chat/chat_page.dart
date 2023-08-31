import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/src/features/chat/presentation/blocs/chat_list_cubit.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
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
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              child: Text(
                                chatListState.messages[index].userId ?? 'asd',
                                style: const TextStyle(
                                  color: CupertinoColors.destructiveRed,
                                ),
                              ),
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
