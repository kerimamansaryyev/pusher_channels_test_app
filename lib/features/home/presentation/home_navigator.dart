import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/chat/presentation/chat_navigator.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/settings_navigator.dart';
import 'package:pusher_channels_test_app/navigation/app_navigator.dart';
import 'package:pusher_channels_test_app/navigation/per_page_navigator_mixin.dart';

@injectable
final class HomeNavigator
    with PerPageNavigatorMixin, SettingsPageRouteMixin, ChatPageRouteMixin {
  @override
  final AppNavigator appNavigator;

  const HomeNavigator({
    required this.appNavigator,
  });

  factory HomeNavigator.fromEnvironment() => serviceLocator<HomeNavigator>();
}
