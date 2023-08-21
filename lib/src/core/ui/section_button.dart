import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_typography.dart';

class SectionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final IconData? iconData;
  final Widget? trailing;
  final Widget? content;
  final Color? overrideActiveColor;

  const SectionButton({
    required this.title,
    required this.onPressed,
    required this.iconData,
    this.overrideActiveColor,
    this.trailing,
    this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: AppTheme.sectionItemPadding(context),
      child: Row(
        children: [
          if (iconData != null) ...[
            Icon(
              iconData,
              color: overrideActiveColor,
              size: 20.adaptedPx(context),
            ),
            const SizedBox(
              width: AppTheme.sectionsDividingSpace,
            ),
          ],
          Expanded(
            child: content ??
                Text(
                  title,
                  style: AppTypographies.h2.style(context).copyWith(
                        fontWeight: FontWeight.normal,
                        color: overrideActiveColor,
                      ),
                ),
          ),
          if (trailing != null)
            IconTheme(
              data: IconTheme.of(context).copyWith(
                color: overrideActiveColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                child: trailing,
              ),
            )
        ],
      ),
    );
  }
}
