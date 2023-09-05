import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/di/injection_container.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
@injectableInit
Future<void> configureInjection() async {
  await $initGetIt(serviceLocator);
}

Future<void> initDependencies() async {
  await configureInjection();
  await serviceLocator.allReady();
}
