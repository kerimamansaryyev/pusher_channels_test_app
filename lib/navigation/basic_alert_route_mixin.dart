import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/navigation/app_navigator.dart';
import 'package:pusher_channels_test_app/navigation/per_page_navigator_mixin.dart';

mixin BasicAlertRouteMixin on PerPageNavigatorMixin {
  void showBasicAlert(
    BuildContext? context, {
    required String title,
    required String description,
  }) =>
      showCupertinoDialog(
        barrierDismissible: true,
        context: context ?? AppNavigator.navigatorKey.currentState!.context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            title,
            maxLines: 1,
            textScaleFactor: 1,
          ),
          content: Text(
            description,
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () => appNavigator.pop(
                context: context,
              ),
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
