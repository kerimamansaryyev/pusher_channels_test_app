import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_list_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_new_messages_button_visibility.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/chat_navigator.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_presenter.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_view.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/widgets/chat_event_notification_widget.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart';
import 'package:pusher_channels_test_app/localization/extensions.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> implements ChatPageView {
  final ScrollController _scrollController = ScrollController();
  bool _isScrollingToBottom = false;
  final ChatNavigator _chatNavigator = ChatNavigator.fromEnvironment();
  late final ChatPagePresenter _presenter = ChatPagePresenter.fromEnvironment()
    ..bindView(this);

  @override
  void initState() {
    _presenter.installConnection();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  double get _currentScrollOffsetDifference {
    return _scrollController.position.maxScrollExtent -
        _scrollController.offset;
  }

  void _scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _isScrollingToBottom = true;
      });

      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 10000,
        duration: const Duration(
          seconds: 1,
        ),
        curve: Curves.ease,
      );
      setState(() {
        _isScrollingToBottom = false;
      });
    });
  }

  void _triggerMessage(String message) => _presenter.triggerMessage(message);

  void _scrollListener() {
    if (_currentScrollOffsetDifference < 5) {
      _presenter.setButtonInvisible();
    }
  }

  @override
  bool get canShowButton => _currentScrollOffsetDifference > 15;

  @override
  void scrollToBottom() => _scrollToBottom();

  @override
  void showMessageNotTriggeredError({
    required String title,
    required String description,
  }) =>
      _chatNavigator.showBasicAlert(
        context,
        title: title,
        description: description,
      );

  @override
  void dispose() {
    _presenter.dispose();
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
          return _presenter.buildMultiBlocListener(
            context,
            BlocBuilder<BlocBase<PusherChannelsConnectionState>,
                PusherChannelsConnectionState>(
              bloc: _presenter.readPusherChannelsConnectionCubit,
              builder: (context, connectionState) =>
                  BlocBuilder<BlocBase<ChatListState>, ChatListState>(
                bloc: _presenter.readChatListCubit,
                builder: (context, chatListState) =>
                    switch (connectionState.connectionResult) {
                  PusherChannelsConnectionSucceeded() => chatListState.when(
                      succeeded: (messages) => Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: CustomScrollView(
                                    physics: _isScrollingToBottom
                                        ? const ClampingScrollPhysics()
                                        : null,
                                    controller: _scrollController,
                                    slivers: [
                                      SliverPadding(
                                        padding: EdgeInsets.only(
                                          top: AppTheme.navBarPadding(context),
                                        ),
                                        sliver: SliverList.builder(
                                          itemBuilder: (context, index) {
                                            final eventEntity = messages[index];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                              ).copyWith(
                                                bottom: AppTheme
                                                    .sectionsDividingSpace,
                                              ),
                                              child: switch (eventEntity) {
                                                PusherChannelsChatBeganEventEntity() ||
                                                PusherChannelsUserJoinedEventEntity() ||
                                                PusherChannelsUserLeftEventEntity() =>
                                                  ChatEventNotificationWidget(
                                                    eventEntity: eventEntity,
                                                  ),
                                                PusherChannelsUserMessageEventEntity() =>
                                                  ChatMessageBubble(
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CupertinoButton.filled(
                                    onPressed: () =>
                                        _chatNavigator.showMessageOptionsDialog(
                                      context,
                                      onMessageChosen: _triggerMessage,
                                    ),
                                    child: Text(
                                      context.translation.triggerClientEvent,
                                    ),
                                  ),
                                ),
                                BlocBuilder<
                                    BlocBase<
                                        ChatNewMessagesButtonVisibilityState>,
                                    ChatNewMessagesButtonVisibilityState>(
                                  bloc: _presenter
                                      .readChatNewMessagesButtonVisibilityCubit,
                                  builder: (context, state) {
                                    return AnimatedSize(
                                      curve: Curves.easeIn,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: Visibility(
                                        visible: state.isVisible,
                                        maintainSize: false,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                          ),
                                          child: CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              SchedulerBinding.instance
                                                  .addPostFrameCallback(
                                                      (timeStamp) {
                                                _scrollToBottom();
                                              });
                                            },
                                            child: const Center(
                                              child: Icon(
                                                CupertinoIcons.envelope_badge,
                                                size: 30,
                                                color:
                                                    CupertinoColors.activeGreen,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
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
                              onPressed: () => _presenter.installConnection(),
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
