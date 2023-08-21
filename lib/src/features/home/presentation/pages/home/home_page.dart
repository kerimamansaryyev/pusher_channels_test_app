import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/src/features/home/presentation/home_navigator.dart';

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
      child: Center(
        child: Text(
          'data',
        ),
      ),
    );
  }
}
