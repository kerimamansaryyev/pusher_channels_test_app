import 'package:adaptix/adaptix.dart';
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

  void _onConnectionChanged(PusherChannelsConnectionState connectionState) {
    if (connectionState.connectionResult
        case PusherChannelsConnectionSucceeded()) {
      _chatListCubit.startListening();
    } else if (connectionState.connectionResult
        case PusherChannelsConnectionPending()) {
      _chatListCubit.resetToWaitingForSubscription();
    }
  }

  @override
  void dispose() {
    _pusherChannelsConnectionCubit.close();
    _chatListCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const loader = Center(
      child: CupertinoActivityIndicator(),
    );

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
                listener: (context, state) => _onConnectionChanged(
                  state,
                ),
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
                  PusherChannelsConnectionSucceeded() => chatListState.when(
                      succeeded: (messages) => Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.only(
                                    top: AppTheme.navBarPadding(context),
                                  ),
                                  sliver: SliverList.builder(
                                    itemBuilder: (context, index) {
                                      final eventEntity = messages[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ).copyWith(
                                          bottom:
                                              AppTheme.sectionsDividingSpace,
                                        ),
                                        child: switch (eventEntity) {
                                          PusherChannelsChatBeganEventEntity() ||
                                          PusherChannelsUserJoinedEventEntity() ||
                                          PusherChannelsUserLeftEventEntity() =>
                                            _EventNotification(
                                              eventEntity: eventEntity,
                                            ),
                                          PusherChannelsUserMessageEventEntity() =>
                                            _MessageBubble(
                                              eventEntity: eventEntity,
                                            ),
                                        },
                                      );
                                    },
                                    itemCount: messages.length,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: CupertinoButton.filled(
                                    onPressed: () {},
                                    child: Text(
                                      context.translation.triggerClientEvent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppTheme.bottomPadding(context),
                          )
                        ],
                      ),
                      waitingForSubscription: () => loader,
                    ),
                  PusherChannelsConnectionPending() => loader,
                  PusherChannelsConnectionFailed(exception: final exception) =>
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.translation.errorOccurred(
                              exception.runtimeType.toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: CupertinoButton(
                              onPressed: () =>
                                  _pusherChannelsConnectionCubit.connect(),
                              child: Icon(
                                CupertinoIcons.refresh,
                                size: 36.adaptedPx(context),
                              ),
                            ),
                          )
                        ],
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

class _MessageBubble extends StatelessWidget {
  final PusherChannelsUserMessageEventEntity eventEntity;

  const _MessageBubble({
    required this.eventEntity,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final userId = eventEntity.userId;

    const paddingOfUserLabel = 7.0;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.activeGreen,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  child: Text(
                    eventEntity.messageContent,
                    style: AppTypographies.b2.style(context).copyWith(
                          color: CupertinoColors.label.darkColor,
                        ),
                  ),
                ),
                if (userId != null) ...[
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: eventEntity.isMyMessage ? paddingOfUserLabel : 0,
                      left: eventEntity.isMyMessage ? 0 : paddingOfUserLabel,
                    ),
                    child: Text(
                      context.translation.messageOfUser(userId),
                      style: AppTypographies.b4.style(context).copyWith(
                            color: CupertinoDynamicColor.resolve(
                              CupertinoColors.secondaryLabel,
                              context,
                            ),
                          ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventNotification extends StatelessWidget {
  final PusherChannelsEventEntity eventEntity;

  const _EventNotification({
    required this.eventEntity,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              switch (eventEntity) {
                PusherChannelsChatBeganEventEntity(
                  myUserId: final myUserId,
                ) =>
                  context.translation.chatBegan(
                    myUserId.toString(),
                  ),
                PusherChannelsUserJoinedEventEntity(userId: final userId) =>
                  context.translation.userJoined(
                    userId.toString(),
                  ),
                PusherChannelsUserLeftEventEntity(userId: final userId) =>
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
