import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/pages/chat/chat_page.dart';
import 'package:pusher_channels_test_app/navigation/app_navigator.dart';
import 'package:pusher_channels_test_app/navigation/basic_alert_route_mixin.dart';
import 'package:pusher_channels_test_app/navigation/per_page_navigator_mixin.dart';

typedef ChooseMessageCallback = void Function(String message);

@injectable
final class ChatNavigator
    with
        PerPageNavigatorMixin,
        BasicAlertRouteMixin,
        ChatMessageSelectionRouteMixin {
  @override
  final AppNavigator appNavigator;

  const ChatNavigator({
    required this.appNavigator,
  });

  factory ChatNavigator.fromEnvironment() => serviceLocator<ChatNavigator>();
}

mixin ChatPageRouteMixin on PerPageNavigatorMixin {
  void navigateToChatPage(BuildContext? context) => appNavigator.push(
        CupertinoPageRoute(
          builder: (context) => const ChatPage(),
        ),
        context: context,
      );
}

mixin ChatMessageSelectionRouteMixin on PerPageNavigatorMixin {
  void showMessageOptionsDialog(
    BuildContext? context, {
    required ChooseMessageCallback onMessageChosen,
  }) {
    showCupertinoModalPopup(
      context: context ?? AppNavigator.navigatorKey.currentState!.context,
      builder: (context) {
        void popWithLocale(String message) {
          onMessageChosen(message);
          Navigator.of(context).pop();
        }

        const marko = 'Marko';
        const polo = 'Polo';

        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => popWithLocale(marko),
              child: const Text(marko),
            ),
            CupertinoActionSheetAction(
              onPressed: () => popWithLocale(polo),
              child: const Text(polo),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            isDestructiveAction: true,
            child: Text(
              CupertinoLocalizations.of(context).modalBarrierDismissLabel,
            ),
          ),
        );
      },
    );
  }
}
