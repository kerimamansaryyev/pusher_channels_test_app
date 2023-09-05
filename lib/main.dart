import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/app.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    const PusherChannelsTestApp(),
  );
}
