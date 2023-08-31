import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart';
import 'package:pusher_channels_test_app/src/localization/extensions.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final PusherChannelsConnectionCubit _pusherChannelsConnectionCubit =
      PusherChannelsConnectionCubit.fromEnvironment();

  @override
  void initState() {
    _pusherChannelsConnectionCubit.connect();
    super.initState();
  }

  @override
  void dispose() {
    _pusherChannelsConnectionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          context.translation.chatRoom,
          textScaleFactor: 1,
        ),
      ),
      child: BlocBuilder<PusherChannelsConnectionCubit,
          PusherChannelsConnectionState>(
        bloc: _pusherChannelsConnectionCubit,
        builder: (context, connectionState) =>
            switch (connectionState.connectionResult) {
          PusherChannelsConnectionSucceeded() => const SizedBox(),
          PusherChannelsConnectionPending() => const Center(
              child: CupertinoActivityIndicator(),
            ),
          PusherChannelsConnectionFailed(exception: final exception) => Center(
              child: Text(
                context.translation.errorOccurred(
                  exception.runtimeType.toString(),
                ),
              ),
            ),
        },
      ),
    );
  }
}
