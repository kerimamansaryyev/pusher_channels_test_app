import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/src/features/home/presentation/pages/home/home_page.dart';
import 'package:pusher_channels_test_app/src/features/settings/domain/stores/settings_store.dart';
import 'package:pusher_channels_test_app/src/localization/localization_override.dart';
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
        return LocalizationOverride(
          builder: (context) => AdaptixInitializer(
            configs: const AdaptixConfigs.canonical(),
            builder: (context) {
              return BlocBuilder<SettingsStoreCubit, SettingsStoreState>(
                bloc: SettingsStoreCubit.fromEnvironment(),
                builder: (context, settingsStoreState) {
                  final theme = settingsStoreState.theme;
                  return CupertinoTheme(
                    data: theme?.cupertinoThemeData(context) ??
                        switch (MediaQuery.of(context).platformBrightness) {
                          Brightness.dark => const AppTheme.dark(),
                          Brightness.light => const AppTheme.light(),
                        }
                            .cupertinoThemeData(context),
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
          ),
        );
      },
    );
  }
}
