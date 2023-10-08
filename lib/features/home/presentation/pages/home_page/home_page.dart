import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/core/ui/section_button.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/home/presentation/home_navigator.dart';
import 'package:pusher_channels_test_app/localization/extensions.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeNavigator = HomeNavigator.fromEnvironment();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Pusher Channels Test',
          textScaleFactor: 1,
          overflow: TextOverflow.ellipsis,
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
                    iconData: CupertinoIcons.chat_bubble,
                    onPressed: () => _homeNavigator.navigateToChatPage(context),
                    title: context.translation.enterChatRoom,
                  ),
                  SectionButton(
                    iconData: CupertinoIcons.settings,
                    onPressed: () => _homeNavigator.navigateToSettings(
                      context,
                      previousPageTitle: (context) =>
                          context.translation.navigateBack,
                    ),
                    title: context.translation.settings,
                  ),
                ],
              ),
              const SizedBox(
                height: AppTheme.sectionsDividingSpace,
              ),
              CupertinoFormSection.insetGrouped(
                margin: EdgeInsets.zero,
                children: [
                  SectionButton(
                    iconData: CupertinoIcons.info,
                    onPressed: () => launchUrlString(
                      'https://test.pusher.com',
                      mode: LaunchMode.externalApplication,
                    ),
                    title: context.translation.disclaimer,
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
