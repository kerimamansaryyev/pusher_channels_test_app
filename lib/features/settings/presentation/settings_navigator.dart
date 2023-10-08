import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/pages/settings_page/settings_page.dart';
import 'package:pusher_channels_test_app/localization/localization_service.dart';
import 'package:pusher_channels_test_app/navigation/app_navigator.dart';
import 'package:pusher_channels_test_app/navigation/per_page_navigator_mixin.dart';

typedef ChooseLanguageCallback = void Function(Locale locale);
typedef PreviousPageLabelResolver = String? Function(BuildContext context);

@injectable
final class SettingsNavigator
    with PerPageNavigatorMixin, SettingsChooseLanguageDialogMixin {
  @override
  final AppNavigator appNavigator;

  const SettingsNavigator({
    required this.appNavigator,
  });

  factory SettingsNavigator.fromEnvironment() =>
      serviceLocator<SettingsNavigator>();
}

mixin SettingsPageRouteMixin on PerPageNavigatorMixin {
  void navigateToSettings(
    BuildContext? context, {
    required PreviousPageLabelResolver? previousPageTitle,
  }) {
    appNavigator.push(
      CupertinoPageRoute(
        builder: (context) => SettingsPage(
          previousPageTitle: previousPageTitle?.call(context),
        ),
      ),
      context: context,
    );
  }
}

mixin SettingsChooseLanguageDialogMixin on PerPageNavigatorMixin {
  void showLanguageDialog(
    BuildContext? context, {
    required ChooseLanguageCallback onLanguageChosen,
  }) {
    showCupertinoModalPopup(
      context: context ?? AppNavigator.navigatorKey.currentState!.context,
      builder: (context) {
        void popWithLocale(Locale locale) {
          onLanguageChosen(locale);
          Navigator.of(context).pop();
        }

        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => popWithLocale(LocalizationService.tkLocale),
              child: const Text('Türkmen'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => popWithLocale(LocalizationService.ruLocale),
              child: const Text('Русский'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => popWithLocale(LocalizationService.enLocale),
              child: const Text('English'),
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
