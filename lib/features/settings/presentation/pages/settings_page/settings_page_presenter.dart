import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/utils/mvp/app_presenter.dart';
import 'package:pusher_channels_test_app/di/injection_container.dart';
import 'package:pusher_channels_test_app/features/settings/domain/stores/settings_store_cubit.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/pages/settings_page/settings_page_model.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/pages/settings_page/settings_page_view.dart';

@injectable
final class SettingsPagePresenter
    extends AppPresenter<SettingsPageView, SettingsPageModel> {
  @override
  final SettingsPageModel model;

  SettingsPagePresenter(this.model);

  factory SettingsPagePresenter.fromEnvironment() =>
      serviceLocator<SettingsPagePresenter>();

  BlocBase<SettingsStoreState> get readSettingsStoreCubit =>
      model.settingsStoreCubit;

  void toggleTheme(bool value) => model.settingsStoreCubit.toggleTheme(value);

  void chooseLanguage(Locale newLocale) =>
      model.settingsStoreCubit.chooseLanguage(newLocale);

  @override
  Widget buildMultiBlocListener(
    BuildContext context,
    Widget child, {
    Key? key,
  }) {
    return child;
  }
}
