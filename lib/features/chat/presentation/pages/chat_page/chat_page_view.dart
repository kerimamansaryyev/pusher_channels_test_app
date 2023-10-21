import 'package:pusher_channels_test_app/core/utils/mvp/app_view.dart';

abstract interface class ChatPageView implements AppView {
  bool get canShowNewMessagesButton;
  void scrollToBottom();
  void showMessageNotTriggeredError({
    required String title,
    required String description,
  });
}
