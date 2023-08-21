import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pusher_channels_test_app/src/features/settings/domain/stores/settings_store.dart';
import 'package:pusher_channels_test_app/src/localization/localization_service.dart';

class LocalizationOverride extends StatelessWidget {
  final Widget Function(BuildContext) builder;
  const LocalizationOverride({required this.builder, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsStoreCubit, SettingsStoreState>(
      bloc: SettingsStoreCubit.fromEnvironment(),
      builder: (context, settingsStoreState) => Localizations.override(
        context: context,
        locale: settingsStoreState.locale,
        delegates: LocalizationService.delegates,
        child: Builder(
          builder: (context) {
            return builder(context);
          },
        ),
      ),
    );
  }
}
