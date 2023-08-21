import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/di/injection_container.dart';
import 'package:pusher_channels_test_app/src/features/settings/presentation/settings_navigator.dart';
import 'package:pusher_channels_test_app/src/navigation/app_navigator.dart';
import 'package:pusher_channels_test_app/src/navigation/per_page_navigator_mixin.dart';

@injectable
final class HomeNavigator with PerPageNavigatorMixin, SettingsPageRouteMixin {
  @override
  final AppNavigator appNavigator;

  const HomeNavigator({
    required this.appNavigator,
  });

  factory HomeNavigator.fromEnvironment() => serviceLocator<HomeNavigator>();
}
