import 'package:adaptix/adaptix.dart';
import 'package:flutter/cupertino.dart';
import 'package:pusher_channels_test_app/src/core/utils/theme/app_typography.dart';

extension AppThemeExtension on AppTheme {
  T when<T>({
    required T light,
    required T dark,
  }) {
    return switch (this) {
      _AppLightTheme() => light,
      _AppDarkTheme() => dark,
    };
  }
}

sealed class AppTheme {
  static const _defaultCupertinoThemeData = CupertinoThemeData();
  static const sectionsDividingSpace = 20.0;

  abstract final String name;

  const factory AppTheme.dark() = _AppDarkTheme;
  const factory AppTheme.light() = _AppLightTheme;

  factory AppTheme.findByName(String name) {
    return switch (name) {
      'light' => const _AppLightTheme(),
      'dark' => const _AppDarkTheme(),
      String() => const _AppLightTheme(),
    };
  }

  CupertinoThemeData cupertinoThemeData(
    BuildContext context,
  );

  static double navBarPadding(BuildContext context) =>
      MediaQuery.of(context).padding.top + sectionsDividingSpace;

  static double bottomPadding(BuildContext context) =>
      MediaQuery.of(context).padding.bottom + 15.adaptedPx(context);

  static double horizontalBodyPadding(BuildContext context) =>
      context.responsiveSwitch(
        CanonicalResponsiveBreakpoint.createCanonicalSwitchArguments(
          defaultValue: 5.widthFraction(context),
          fablet: 7.widthFraction(context),
          tablet: 9.widthFraction(context),
          desktop: 9.widthFraction(
            context,
          ),
        ),
      );

  static TextStyle linkTextStyle(BuildContext context) => TextStyle(
        color: CupertinoColors.link.resolveFrom(context),
      );

  static EdgeInsets sectionItemPadding(BuildContext context) =>
      EdgeInsets.symmetric(
        vertical: 16.adaptedPx(context),
        horizontal: 15.adaptedPx(context),
      );
}

@immutable
final class _AppLightTheme implements AppTheme {
  @override
  final String name = 'light';

  const _AppLightTheme();

  @override
  CupertinoThemeData cupertinoThemeData(BuildContext context) {
    return AppTheme._defaultCupertinoThemeData.copyWith(
      brightness: Brightness.light,
      textTheme: CupertinoTextThemeData(
        textStyle:
            AppTheme._defaultCupertinoThemeData.textTheme.textStyle.copyWith(
          fontSize: AppTypographies.b2.style(context).fontSize,
        ),
      ),
    );
  }
}

final class _AppDarkTheme implements AppTheme {
  @override
  final String name = 'dark';

  const _AppDarkTheme();

  @override
  CupertinoThemeData cupertinoThemeData(BuildContext context) {
    return AppTheme._defaultCupertinoThemeData.copyWith(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        navActionTextStyle: AppTheme
            ._defaultCupertinoThemeData.textTheme.navActionTextStyle
            .copyWith(),
        textStyle:
            AppTheme._defaultCupertinoThemeData.textTheme.textStyle.copyWith(
          fontSize: AppTypographies.b2.style(context).fontSize,
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
