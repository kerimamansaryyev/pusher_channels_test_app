import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/core/ui/section_button.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/settings/domain/stores/settings_store.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/settings_navigator.dart';
import 'package:pusher_channels_test_app/localization/extensions.dart';

class SettingsPage extends StatefulWidget {
  final String? previousPageTitle;

  const SettingsPage({
    required this.previousPageTitle,
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _settingsNavigator = SettingsNavigator.fromEnvironment();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: context.translation.navigateBack,
        middle: Text(
          context.translation.settings,
          textScaleFactor: 1,
          style: const TextStyle(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: Builder(
        builder: (context) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.horizontalBodyPadding(context),
            ).copyWith(
              top: AppTheme.navBarPadding(context),
            ),
            children: [
              CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.zero,
                children: [
                  SectionButton(
                    iconData: CupertinoIcons.globe,
                    onPressed: () => _settingsNavigator.showLanguageDialog(
                      context,
                      onLanguageChosen: (newLocale) =>
                          SettingsStoreCubit.fromEnvironment().chooseLanguage(
                        newLocale,
                      ),
                    ),
                    title: context.translation.language,
                  ),
                  BlocBuilder<SettingsStoreCubit, SettingsStoreState>(
                    bloc: SettingsStoreCubit.fromEnvironment(),
                    builder: (context, settingsStoreState) {
                      final state = settingsStoreState.theme;
                      final isDark =
                          (state?.cupertinoThemeData(context).brightness ??
                                  mediaQuery.platformBrightness) ==
                              Brightness.dark;
                      return SectionButton(
                        title: context.translation.theme,
                        onPressed: () => SettingsStoreCubit.fromEnvironment()
                            .toggleTheme(!isDark),
                        iconData: isDark
                            ? CupertinoIcons.moon_stars
                            : CupertinoIcons.sun_max,
                        trailing: CupertinoSwitch(
                          value: isDark,
                          onChanged: (newValue) =>
                              SettingsStoreCubit.fromEnvironment().toggleTheme(
                            newValue,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
