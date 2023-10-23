import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_presenter.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat_page/chat_page_view.dart';
import 'package:pusher_channels_test_app/localization/localization_service.dart';

import '../../../mocks/test_mocks.mocks.dart';

final class TestChatPageDriver {
  GlobalKey<_TestChatPageState>? _widgetGlobalKey;
  Key? _multiBlocListenerKey;

  @protected
  final MockChatPageView viewAdapter;
  @protected
  final ChatPagePresenter chatPagePresenter;

  TestChatPageDriver({
    required this.chatPagePresenter,
    required this.viewAdapter,
  });

  ChatPageView? get realView => _widgetGlobalKey?.currentState;
  Key? get multiBlocListenerKey => _multiBlocListenerKey;
  BuildContext? get context => _widgetGlobalKey?.currentContext;

  Widget buildWidget() => CupertinoApp(
        localizationsDelegates: LocalizationService.delegates,
        home: _TestChatPage(
          multiBlocListenerKey: _multiBlocListenerKey =
              const ValueKey('MultiBlocListener'),
          key: _widgetGlobalKey = GlobalKey(),
          presenter: chatPagePresenter,
          viewAdapter: viewAdapter,
        ),
      );

  void setConnection() => chatPagePresenter.installConnection();
  void triggerMessage(String content) => chatPagePresenter.triggerMessage(
        content,
      );

  void dispose() => chatPagePresenter.dispose();
}

class _TestChatPage extends StatefulWidget {
  final ChatPagePresenter presenter;
  final MockChatPageView viewAdapter;
  final Key multiBlocListenerKey;

  const _TestChatPage({
    required this.multiBlocListenerKey,
    required this.presenter,
    required this.viewAdapter,
    super.key,
  });

  @override
  State<_TestChatPage> createState() => _TestChatPageState();
}

class _TestChatPageState extends State<_TestChatPage> implements ChatPageView {
  ChatPagePresenter get _presenter => widget.presenter;
  MockChatPageView get _mockView => widget.viewAdapter;

  @override
  void initState() {
    _presenter.bindView(this);
    super.initState();
  }

  @override
  void scrollToBottom() {
    _mockView.scrollToBottom();
  }

  @override
  void showMessageNotTriggeredError({
    required String title,
    required String description,
  }) {
    _mockView.showMessageNotTriggeredError(
      title: title,
      description: description,
    );
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _presenter.buildMultiBlocListener(
      context,
      const Placeholder(),
      key: widget.multiBlocListenerKey,
    );
  }

  @override
  bool get canShowNewMessagesButton => _mockView.canShowNewMessagesButton;
}
