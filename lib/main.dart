import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/src/app.dart';
import 'package:pusher_channels_test_app/src/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    const PusherChannelsTestApp(),
  );
}
