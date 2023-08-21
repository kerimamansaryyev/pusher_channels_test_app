import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/src/features/home/presentation/pages/home/home_page.dart';
import 'package:pusher_channels_test_app/src/localization/localization_service.dart';
import 'package:pusher_channels_test_app/src/navigation/app_navigator.dart';

class PusherChannelsTestApp extends StatefulWidget {
  const PusherChannelsTestApp({super.key});

  @override
  State<PusherChannelsTestApp> createState() => _PusherChannelsTestAppState();
}

class _PusherChannelsTestAppState extends State<PusherChannelsTestApp> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: const HomePage(),
      navigatorKey: AppNavigator.navigatorKey,
      localizationsDelegates: LocalizationService.delegates,
      supportedLocales: LocalizationService.supportedLocales,
      builder: (context, child) {
        return AdaptixInitializer(
          configs: const AdaptixConfigs.canonical(),
          builder: (context) {
            return CupertinoTheme(
              data: const CupertinoThemeData(),
              child: Builder(
                builder: (context) {
                  return DefaultTextStyle(
                    style: CupertinoTheme.of(context).textTheme.textStyle,
                    child: child!,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
