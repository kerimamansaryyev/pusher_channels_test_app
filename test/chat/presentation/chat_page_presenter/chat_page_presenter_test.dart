import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/reset_presence_channel_state.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/subscribe_and_listen_to_presence_channel_events.dart';
import 'package:pusher_channels_test_app/features/chat/domain/usecases/trigger_client_event_on_presence_channel.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_list_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_message_trigger_cubit.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/blocs/chat_new_messages_button_visibility.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_model.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_presenter.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/message_not_triggered_failure.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/use-cases/reset_pusher_channels_client.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart';

import '../../../mocks/dummy_failure.dart';
import '../../../mocks/test_mocks.mocks.dart';
import 'test_chat_page.dart';

final _getIt = GetIt.instance..allowReassignment = true;

Future<void> _injectAllAsDefaults() => _injectAll(
      connectPusherChannelsClient: MockConnectPusherChannelsClient(),
      resetPusherChannelsClient: MockResetPusherChannelsClient(),
      listenForPusherChannelsClientConnection:
          MockListenForPusherChannelsClientConnection(),
      resetPresenceChannelState: MockResetPresenceChannelState(),
      subscribeAndListenToPresenceChannelEvents:
          MockSubscribeAndListenToPresenceChannelEvents(),
      triggerClientEventOnPresenceChannel:
          MockTriggerClientEventOnPresenceChannel(),
    );

Future<(ChatPagePresenter, MockChatPageView, TestChatPageDriver)>
    _preparePage() async {
  final presenter = _getIt<ChatPagePresenter>();
  final viewAdapter = MockChatPageView();
  final viewDriver = TestChatPageDriver(
    chatPagePresenter: presenter,
    viewAdapter: viewAdapter,
  );
  return (
    presenter,
    viewAdapter,
    viewDriver,
  );
}

Future<void> _inject({
  MockConnectPusherChannelsClient? connectPusherChannelsClient,
  MockResetPusherChannelsClient? resetPusherChannelsClient,
  MockListenForPusherChannelsClientConnection?
      listenForPusherChannelsClientConnection,
  MockResetPresenceChannelState? resetPresenceChannelState,
  MockSubscribeAndListenToPresenceChannelEvents?
      subscribeAndListenToPresenceChannelEvents,
  MockTriggerClientEventOnPresenceChannel? triggerClientEventOnPresenceChannel,
}) =>
    _injectAll(
      connectPusherChannelsClient:
          connectPusherChannelsClient ?? MockConnectPusherChannelsClient(),
      resetPusherChannelsClient:
          resetPusherChannelsClient ?? MockResetPusherChannelsClient(),
      listenForPusherChannelsClientConnection:
          listenForPusherChannelsClientConnection ??
              MockListenForPusherChannelsClientConnection(),
      resetPresenceChannelState:
          resetPresenceChannelState ?? MockResetPresenceChannelState(),
      subscribeAndListenToPresenceChannelEvents:
          subscribeAndListenToPresenceChannelEvents ??
              MockSubscribeAndListenToPresenceChannelEvents(),
      triggerClientEventOnPresenceChannel:
          triggerClientEventOnPresenceChannel ??
              MockTriggerClientEventOnPresenceChannel(),
    );

Future<void> _injectAll({
  required MockConnectPusherChannelsClient connectPusherChannelsClient,
  required MockResetPusherChannelsClient resetPusherChannelsClient,
  required MockListenForPusherChannelsClientConnection
      listenForPusherChannelsClientConnection,
  required MockResetPresenceChannelState resetPresenceChannelState,
  required MockSubscribeAndListenToPresenceChannelEvents
      subscribeAndListenToPresenceChannelEvents,
  required MockTriggerClientEventOnPresenceChannel
      triggerClientEventOnPresenceChannel,
}) {
  _getIt.registerSingleton<ConnectPusherChannelsClient>(
    connectPusherChannelsClient,
  );
  _getIt.registerSingleton<ResetPusherChannelsClient>(
    resetPusherChannelsClient,
  );
  _getIt.registerSingleton<ListenForPusherChannelsClientConnection>(
    listenForPusherChannelsClientConnection,
  );
  _getIt.registerSingleton<SubscribeAndListenToPresenceChannelEvents>(
    subscribeAndListenToPresenceChannelEvents,
  );
  _getIt.registerSingleton<ResetPresenceChannelState>(
    resetPresenceChannelState,
  );
  _getIt.registerSingleton<TriggerClientEventOnPresenceChannel>(
    triggerClientEventOnPresenceChannel,
  );

  _getIt.registerFactory<ChatMessageTriggerCubit>(
    () => ChatMessageTriggerCubit(
      _getIt(),
    ),
  );

  _getIt.registerFactory<ChatListCubit>(
    () => ChatListCubit(
      _getIt(),
      _getIt(),
    ),
  );

  _getIt.registerFactory<PusherChannelsConnectionCubit>(
    () => PusherChannelsConnectionCubit(
      _getIt(),
      _getIt(),
      _getIt(),
    ),
  );

  _getIt.registerFactory<ChatNewMessagesButtonVisibilityCubit>(
    () => ChatNewMessagesButtonVisibilityCubit(),
  );

  _getIt.registerFactory<ChatPageModel>(
    () => ChatPageModel(
      _getIt(),
      _getIt(),
      _getIt(),
      _getIt(),
    ),
  );
  _getIt.registerFactory<ChatPagePresenter>(
    () => ChatPagePresenter(
      _getIt(),
    ),
  );

  return _getIt.allReady();
}

void main() {
  group(
    'Chat page testing',
    () {
      setUp(() {
        _getIt.reset();
      });

      testWidgets(
        'ChatPageView interface of the _TestChatPage gets bound to the presenter',
        (tester) async {
          await _injectAllAsDefaults();

          final (presenter, _, viewDriver) = await _preparePage();

          await tester.pumpWidget(
            viewDriver.buildWidget(),
          );

          expect(
            presenter.getViewTest(),
            equals(viewDriver.realView),
          );
          expect(
            find.byKey(viewDriver.multiBlocListenerKey!),
            findsOneWidget,
          );
        },
      );
      group(
        'Testing message triggering',
        () {
          final listenForPusherChannelsClientConnection =
              MockListenForPusherChannelsClientConnection();
          final subscribeAndListenToPresenceChannelEvents =
              MockSubscribeAndListenToPresenceChannelEvents();
          final triggerClientMessageOnPresenceChannel =
              MockTriggerClientEventOnPresenceChannel();

          setUp(
            () async {
              [
                listenForPusherChannelsClientConnection,
                subscribeAndListenToPresenceChannelEvents,
                triggerClientMessageOnPresenceChannel,
              ].forEach(clearInteractions);
              when(listenForPusherChannelsClientConnection.call()).thenAnswer(
                (realInvocation) => Stream.fromIterable(const [
                  PusherChannelsConnectionPending(),
                  PusherChannelsConnectionSucceeded(),
                ]),
              );
              when(
                subscribeAndListenToPresenceChannelEvents.call(
                  eventNameToBind: anyNamed('eventNameToBind'),
                ),
              ).thenAnswer(
                (realInvocation) => Stream.fromIterable(
                  [
                    MockPusherChannelsChatBeganEventEntity(),
                  ],
                ),
              );
              await _inject(
                listenForPusherChannelsClientConnection:
                    listenForPusherChannelsClientConnection,
                subscribeAndListenToPresenceChannelEvents:
                    subscribeAndListenToPresenceChannelEvents,
                triggerClientEventOnPresenceChannel:
                    triggerClientMessageOnPresenceChannel,
              );
            },
          );

          testWidgets(
            'Triggered messages will be added to ChatListCubit and the view will be scrolled to bottom',
            (widgetTester) async {
              final (presenter, chatPageView, viewDriver) =
                  await _preparePage();

              const expectedMessage = 'Hello';
              provideDummyBuilder<
                  Either<Failure<Exception>,
                      PusherChannelsUserMessageEventEntity>>(
                (parent, invocation) => const Left(
                  DummyFailure(),
                ),
              );
              when(
                triggerClientMessageOnPresenceChannel.call(
                  message: anyNamed('message'),
                ),
              ).thenAnswer(
                (realInvocation) {
                  final answer = MockPusherChannelsUserMessageEventEntity();
                  when(answer.isMyMessage).thenReturn(true);
                  when(answer.messageContent).thenReturn(
                    realInvocation.namedArguments[#message],
                  );
                  return Right(answer);
                },
              );

              await widgetTester.pumpWidget(viewDriver.buildWidget());

              viewDriver.setConnection();

              await widgetTester.pumpAndSettle();

              viewDriver.triggerMessage(
                expectedMessage,
              );

              widgetTester.binding.scheduleFrame();
              await widgetTester.pumpAndSettle();

              final messageMatcher =
                  isA<PusherChannelsUserMessageEventEntity>().having(
                (message) => message.messageContent,
                'messageContent',
                expectedMessage,
              );

              presenter.readChatMessageTriggerCubit.state.whenOrNull(
                triggered: (message) => expect(
                  message,
                  messageMatcher,
                ),
                failed: (_) => fail(
                  'Triggering must not be failed at this point',
                ),
                initial: () => fail(
                  'Message was not triggered',
                ),
              );

              expect(
                presenter.readChatListCubit.state.when(
                  succeeded: (messages) => messages.last,
                  waitingForSubscription: () => null,
                ),
                messageMatcher,
              );

              verify(chatPageView.scrollToBottom()).called(1);

              viewDriver.dispose();
            },
          );

          testWidgets(
            'If triggering the message fails and the failure type is MessageNotTriggeredFailure - the presenter will show the alert through view',
            (widgetTester) async {
              final (presenter, chatPageView, viewDriver) =
                  await _preparePage();

              provideDummyBuilder<
                  Either<Failure<Exception>,
                      PusherChannelsUserMessageEventEntity>>(
                (parent, invocation) => const Left(
                  DummyFailure(),
                ),
              );
              when(
                triggerClientMessageOnPresenceChannel.call(
                  message: anyNamed('message'),
                ),
              ).thenAnswer(
                (realInvocation) {
                  return const Left(
                    MessageNotTriggeredFailure(),
                  );
                },
              );

              await widgetTester.pumpWidget(viewDriver.buildWidget());

              viewDriver.setConnection();

              await widgetTester.pumpAndSettle();

              viewDriver.triggerMessage(
                'Hello',
              );

              widgetTester.binding.scheduleFrame();
              await widgetTester.pumpAndSettle();

              presenter.readChatMessageTriggerCubit.state.whenOrNull(
                triggered: (message) =>
                    fail('At this point triggering must not be succeeding'),
                failed: (failure) => expect(
                  failure,
                  isA<MessageNotTriggeredFailure>(),
                ),
                initial: () => fail(
                  'Message was not triggered',
                ),
              );

              expect(
                presenter.readChatListCubit.state.when(
                  succeeded: (messages) => messages.length,
                  waitingForSubscription: () => 0,
                ),
                1,
              );

              verifyNever(chatPageView.scrollToBottom()).called(0);
              verify(
                chatPageView.showMessageNotTriggeredError(
                  title: anyNamed('title'),
                  description: anyNamed('description'),
                ),
              ).called(1);

              viewDriver.dispose();
            },
          );
        },
      );
      group(
        'Testing ChatListCubit new message handling',
        () {
          const newMessageReceiveTimeInterval = Duration(seconds: 3);
          final listenForPusherChannelsClientConnection =
              MockListenForPusherChannelsClientConnection();
          final subscribeAndListenToPresenceChannelEvents =
              MockSubscribeAndListenToPresenceChannelEvents();
          late ChatNewMessagesButtonVisibilityCubit
              chatNewMessagesButtonVisibilityCubit;

          Stream<PusherChannelsEventEntity> generateMessages({
            required bool yieldOwnMessage,
          }) async* {
            yield MockPusherChannelsChatBeganEventEntity();
            await Future.delayed(newMessageReceiveTimeInterval);
            final newMessageMock = MockPusherChannelsUserMessageEventEntity();
            when(newMessageMock.isMyMessage).thenReturn(
              yieldOwnMessage,
            );
            yield newMessageMock;
          }

          Future<void> mockViewAndSetConnection({
            required bool isAtTheEdgeOfScroll,
            required bool receivedOwnMessage,
            required WidgetTester widgetTester,
          }) async {
            final (_, view, viewDriver) = await _preparePage();
            when(view.canShowNewMessagesButton).thenReturn(
              !isAtTheEdgeOfScroll,
            );
            when(
              subscribeAndListenToPresenceChannelEvents.call(
                eventNameToBind: anyNamed(
                  'eventNameToBind',
                ),
              ),
            ).thenAnswer(
              (realInvocation) => generateMessages(
                yieldOwnMessage: receivedOwnMessage,
              ),
            );
            await widgetTester.pumpWidget(
              viewDriver.buildWidget(),
            );
            viewDriver.setConnection();
            await Future.delayed(
              newMessageReceiveTimeInterval +
                  const Duration(
                    seconds: 1,
                  ),
            );
          }

          setUp(() async {
            [
              listenForPusherChannelsClientConnection,
              subscribeAndListenToPresenceChannelEvents,
            ].forEach(clearInteractions);

            const expectedOrderEvents = <PusherChannelsConnectionResult>[
              PusherChannelsConnectionPending(),
              PusherChannelsConnectionSucceeded(),
            ];

            when(listenForPusherChannelsClientConnection.call()).thenAnswer(
              (_) => Stream.fromIterable(
                expectedOrderEvents,
              ),
            );
            await _inject(
              subscribeAndListenToPresenceChannelEvents:
                  subscribeAndListenToPresenceChannelEvents,
              listenForPusherChannelsClientConnection:
                  listenForPusherChannelsClientConnection,
            );

            chatNewMessagesButtonVisibilityCubit =
                ChatNewMessagesButtonVisibilityCubit();
            _getIt.registerSingleton<ChatNewMessagesButtonVisibilityCubit>(
              chatNewMessagesButtonVisibilityCubit,
            );
          });

          testWidgets(
            'If the user is at the edge of the scrollview - it will not show the new message button',
            (widgetTester) => widgetTester.runAsync(
              () async {
                expect(
                  chatNewMessagesButtonVisibilityCubit.state.isVisible,
                  false,
                );
                await mockViewAndSetConnection(
                  isAtTheEdgeOfScroll: true,
                  receivedOwnMessage: false,
                  widgetTester: widgetTester,
                );
                widgetTester.binding.scheduleFrame();
                await widgetTester.binding.pump(
                  const Duration(
                    seconds: 1,
                  ),
                );
                expect(
                  chatNewMessagesButtonVisibilityCubit.state.isVisible,
                  false,
                );
              },
            ),
          );
          testWidgets(
            'If the user is at NOT the edge of the scrollview - it will show the new message button',
            (widgetTester) => widgetTester.runAsync(
              () async {
                expect(
                  chatNewMessagesButtonVisibilityCubit.state.isVisible,
                  false,
                );
                await mockViewAndSetConnection(
                  isAtTheEdgeOfScroll: false,
                  receivedOwnMessage: false,
                  widgetTester: widgetTester,
                );
                widgetTester.binding.scheduleFrame();
                await widgetTester.binding.pump(
                  const Duration(
                    seconds: 1,
                  ),
                );
                expect(
                  chatNewMessagesButtonVisibilityCubit.state.isVisible,
                  true,
                );
              },
            ),
          );
          testWidgets(
            'If the user receives its own message - the new message button will not be shown',
            (widgetTester) => widgetTester.runAsync(
              () async {
                expect(
                  chatNewMessagesButtonVisibilityCubit.state.isVisible,
                  false,
                );
                await mockViewAndSetConnection(
                  isAtTheEdgeOfScroll: false,
                  receivedOwnMessage: true,
                  widgetTester: widgetTester,
                );
                widgetTester.binding.scheduleFrame();
                await widgetTester.binding.pump(
                  const Duration(
                    seconds: 1,
                  ),
                );
                expect(
                  chatNewMessagesButtonVisibilityCubit.state.isVisible,
                  false,
                );
              },
            ),
          );
        },
      );
      group(
        'Testing ChatListCubit with PusherChannelsConnectionCubit interaction',
        () {
          final listenForPusherChannelsClientConnection =
              MockListenForPusherChannelsClientConnection();
          final subscribeAndListenToPresenceChannelEvents =
              MockSubscribeAndListenToPresenceChannelEvents();
          final connectPusherClient = MockConnectPusherChannelsClient();
          final resetPresenceChannelState = MockResetPresenceChannelState();

          setUp(() async {
            [
              listenForPusherChannelsClientConnection,
              subscribeAndListenToPresenceChannelEvents,
              connectPusherClient,
              resetPresenceChannelState,
            ].forEach(clearInteractions);
            await _inject(
              resetPresenceChannelState: resetPresenceChannelState,
              subscribeAndListenToPresenceChannelEvents:
                  subscribeAndListenToPresenceChannelEvents,
              listenForPusherChannelsClientConnection:
                  listenForPusherChannelsClientConnection,
              connectPusherChannelsClient: connectPusherClient,
            );
          });

          testWidgets(
            'ChatListCubit starts listening for messages and resets the presence channel state whenever PusherChannelsConnectionCubit succeeds to establish it',
            (widgetTester) async {
              const expectedOrderEvents = <PusherChannelsConnectionResult>[
                PusherChannelsConnectionPending(),
                PusherChannelsConnectionSucceeded(),
                PusherChannelsConnectionPending(),
                PusherChannelsConnectionSucceeded(),
              ];

              when(
                subscribeAndListenToPresenceChannelEvents.call(
                  eventNameToBind: anyNamed('eventNameToBind'),
                ),
              ).thenAnswer(
                (realInvocation) => const Stream.empty(),
              );

              when(listenForPusherChannelsClientConnection.call()).thenAnswer(
                (_) => Stream.fromIterable(
                  expectedOrderEvents,
                ),
              );

              final (_, _, viewDriver) = await _preparePage();

              await widgetTester.pumpWidget(
                viewDriver.buildWidget(),
              );

              await widgetTester.runAsync(() async {
                viewDriver.setConnection();

                await Future.delayed(
                  const Duration(seconds: 1),
                );

                verify(
                  subscribeAndListenToPresenceChannelEvents.call(
                    eventNameToBind: null,
                  ),
                ).called(2);
                verify(
                  resetPresenceChannelState.call(),
                ).called(2);
              });
            },
          );

          testWidgets(
            'ChatListCubit will keep tracking messages but will not show them until it receives the chat-began message',
            (widgetTester) async {
              await widgetTester.runAsync(() async {
                final chatListCubit = ChatListCubit(
                  _getIt(),
                  _getIt(),
                );

                _getIt.registerSingleton<ChatListCubit>(
                  chatListCubit,
                );

                final connectionResultController = StreamController<
                    PusherChannelsConnectionResult>.broadcast();
                const connectionResultOrder = [
                  PusherChannelsConnectionPending(),
                  PusherChannelsConnectionSucceeded(),
                ];
                const chatStartDuration = Duration(seconds: 3);

                Stream<PusherChannelsEventEntity> generateMessages() async* {
                  yield MockPusherChannelsUserJoinedEventEntity();
                  yield MockPusherChannelsUserMessageEventEntity();
                  await Future.delayed(chatStartDuration);
                  yield MockPusherChannelsChatBeganEventEntity();
                }

                when(
                  subscribeAndListenToPresenceChannelEvents.call(
                    eventNameToBind: anyNamed('eventNameToBind'),
                  ),
                ).thenAnswer(
                  (realInvocation) => generateMessages(),
                );

                when(listenForPusherChannelsClientConnection.call()).thenAnswer(
                  (_) => connectionResultController.stream,
                );

                when(connectPusherClient.call()).thenAnswer(
                  (realInvocation) => connectionResultController.addStream(
                    Stream.fromIterable(
                      connectionResultOrder,
                    ),
                  ),
                );

                expect(
                  chatListCubit.getMessagesForTest().length,
                  0,
                );

                final (_, _, viewDriver) = await _preparePage();

                await widgetTester.pumpWidget(
                  viewDriver.buildWidget(),
                );

                viewDriver.setConnection();

                await Future.delayed(
                  chatStartDuration -
                      const Duration(
                        seconds: 1,
                      ),
                );

                expect(
                  chatListCubit.getMessagesForTest().length,
                  2,
                );
                expect(
                  chatListCubit.state.when(
                    succeeded: (_) => false,
                    waitingForSubscription: () => true,
                  ),
                  true,
                );

                await Future.delayed(
                  const Duration(
                    seconds: 2,
                  ),
                );

                expect(
                  chatListCubit.getMessagesForTest().length,
                  3,
                );
                expect(
                  chatListCubit.state.when(
                    succeeded: (_) => true,
                    waitingForSubscription: () => false,
                  ),
                  true,
                );

                viewDriver.dispose();
              });
            },
          );

          testWidgets(
            'The presenter will set the error connection result if ChatListCubit does not receive the subscription event',
            (widgetTester) async {
              await widgetTester.runAsync(() async {
                final connectionResultController = StreamController<
                    PusherChannelsConnectionResult>.broadcast();
                const connectionResultOrder = [
                  PusherChannelsConnectionPending(),
                  PusherChannelsConnectionSucceeded(),
                ];

                when(
                  subscribeAndListenToPresenceChannelEvents.call(
                    eventNameToBind: anyNamed('eventNameToBind'),
                  ),
                ).thenAnswer(
                  (realInvocation) => const Stream.empty(),
                );

                when(listenForPusherChannelsClientConnection.call()).thenAnswer(
                  (_) => connectionResultController.stream,
                );

                when(connectPusherClient.call()).thenAnswer(
                  (realInvocation) => connectionResultController.addStream(
                    Stream.fromIterable(
                      connectionResultOrder,
                    ),
                  ),
                );

                final (presenter, _, viewDriver) = await _preparePage();

                await widgetTester.pumpWidget(
                  viewDriver.buildWidget(),
                );

                unawaited(
                  expectLater(
                    presenter.readPusherChannelsConnectionCubit.stream.map(
                      (event) => event.connectionResult,
                    ),
                    emitsInOrder(
                      [
                        ...connectionResultOrder.map(
                          (e) => equals(e),
                        ),
                        isA<PusherChannelsConnectionFailed>().having(
                          (result) => result.exception,
                          'exception',
                          isA<TimeoutException>(),
                        ),
                      ],
                    ),
                  ),
                );

                viewDriver.setConnection();

                await Future.delayed(
                  ChatPagePresenter.subsWaitingTimeoutDuration +
                      const Duration(
                        seconds: 1,
                      ),
                );

                expect(
                  presenter.readChatListCubit.state.when(
                    succeeded: (_) => false,
                    waitingForSubscription: () => true,
                  ),
                  true,
                );

                viewDriver.dispose();
              });
            },
          );
        },
      );
    },
  );
}
