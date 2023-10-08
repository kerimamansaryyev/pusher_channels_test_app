import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_typography.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/localization/extensions.dart';

class ChatEventNotificationWidget extends StatelessWidget {
  final PusherChannelsEventEntity eventEntity;

  const ChatEventNotificationWidget({
    required this.eventEntity,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              switch (eventEntity) {
                PusherChannelsChatBeganEventEntity(
                  myUserId: final myUserId,
                ) =>
                  context.translation.chatBegan(
                    myUserId.toString(),
                  ),
                PusherChannelsUserJoinedEventEntity(userId: final userId) =>
                  context.translation.userJoined(
                    userId.toString(),
                  ),
                PusherChannelsUserLeftEventEntity(userId: final userId) =>
                  context.translation.userLeft(
                    userId.toString(),
                  ),
                _ => '',
              },
              style: AppTypographies.b3.style(context).copyWith(
                    color: CupertinoDynamicColor.resolve(
                      CupertinoColors.secondaryLabel,
                      context,
                    ),
                  ),
            ),
          ),
        )
      ],
    );
  }
}
