import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/src/features/chat/presentation/pages/chat/chat_page.dart';
import 'package:pusher_channels_test_app/src/navigation/per_page_navigator_mixin.dart';

mixin ChatPageRouteMixin on PerPageNavigatorMixin {
  void navigateToChatPage(BuildContext? context) => appNavigator.push(
        CupertinoPageRoute(
          builder: (context) => const ChatPage(),
        ),
        context: context,
      );
}
