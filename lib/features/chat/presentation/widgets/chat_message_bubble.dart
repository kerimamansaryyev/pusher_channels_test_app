import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_typography.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/localization/extensions.dart';

class ChatMessageBubble extends StatelessWidget {
  final PusherChannelsUserMessageEventEntity eventEntity;

  const ChatMessageBubble({
    required this.eventEntity,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final userId = eventEntity.userId;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Row(
        mainAxisAlignment: eventEntity.isMyMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: eventEntity.isMyMessage
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.activeGreen,
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  padding: const EdgeInsets.all(
                    12,
                  ),
                  child: Text(
                    eventEntity.messageContent,
                    style: AppTypographies.b2.style(context).copyWith(
                          color: CupertinoColors.label.darkColor,
                        ),
                  ),
                ),
                if (userId != null) ...[
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    context.translation.messageOfUser(userId),
                    style: AppTypographies.b4.style(context).copyWith(
                          color: CupertinoDynamicColor.resolve(
                            CupertinoColors.secondaryLabel,
                            context,
                          ),
                        ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
