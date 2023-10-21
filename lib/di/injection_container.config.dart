// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

import '../core/di/injection_module.dart' as _i32;
import '../features/chat/domain/use-cases/reset_presence_channel_state.dart'
    as _i10;
import '../features/chat/domain/use-cases/subscribe_and_listen_to_presence_channel_events.dart'
    as _i14;
import '../features/chat/domain/use-cases/trigger_client_event_on_presence_channel.dart'
    as _i15;
import '../features/chat/presentation/blocs/chat_list_cubit.dart' as _i16;
import '../features/chat/presentation/blocs/chat_message_trigger_cubit.dart'
    as _i17;
import '../features/chat/presentation/blocs/chat_new_messages_button_visibility.dart'
    as _i5;
import '../features/chat/presentation/chat_navigator.dart' as _i4;
import '../features/chat/presentation/pages/chat_page/chat_page_model.dart'
    as _i24;
import '../features/chat/presentation/pages/chat_page/chat_page_presenter.dart'
    as _i25;
import '../features/home/presentation/home_navigator.dart' as _i6;
import '../features/pusher_channels_connection/data/factories/pusher_channels_client_factory.dart'
    as _i7;
import '../features/pusher_channels_connection/data/repositories/pusher_channels_connection_repository_impl.dart'
    as _i9;
import '../features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart'
    as _i8;
import '../features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart'
    as _i18;
import '../features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart'
    as _i19;
import '../features/pusher_channels_connection/domain/use-cases/reset_pusher_channels_client.dart'
    as _i11;
import '../features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart'
    as _i20;
import '../features/settings/data/repositories/settings_repository_impl.dart'
    as _i23;
import '../features/settings/data/storages/settings_preferences.dart' as _i21;
import '../features/settings/domain/repositories/settings_repository.dart'
    as _i22;
import '../features/settings/domain/stores/settings_store_cubit.dart' as _i29;
import '../features/settings/domain/usecases/get_settings_records.dart' as _i26;
import '../features/settings/domain/usecases/save_locale.dart' as _i27;
import '../features/settings/domain/usecases/save_theme.dart' as _i28;
import '../features/settings/presentation/pages/settings_page/settings_page_model.dart'
    as _i30;
import '../features/settings/presentation/pages/settings_page/settings_page_presenter.dart'
    as _i31;
import '../features/settings/presentation/settings_navigator.dart' as _i12;
import '../navigation/app_navigator.dart' as _i3;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModule = _$InjectionModule();
  gh.factory<_i3.AppNavigator>(() => _i3.AppNavigator());
  gh.factory<_i4.ChatNavigator>(
      () => _i4.ChatNavigator(appNavigator: gh<_i3.AppNavigator>()));
  gh.factory<_i5.ChatNewMessagesButtonVisibilityCubit>(
      () => _i5.ChatNewMessagesButtonVisibilityCubit());
  gh.factory<_i6.HomeNavigator>(
      () => _i6.HomeNavigator(appNavigator: gh<_i3.AppNavigator>()));
  gh.factory<_i7.PusherChannelsClientFactory>(
      () => _i7.PusherChannelsClientFactoryImpl());
  gh.lazySingleton<_i8.PusherChannelsConnectionRepository>(() =>
      _i9.PusherChannelsConnectionRepositoryImpl(
          gh<_i7.PusherChannelsClientFactory>()));
  gh.factory<_i10.ResetPresenceChannelState>(() =>
      _i10.ResetPresenceChannelState(
          gh<_i8.PusherChannelsConnectionRepository>()));
  gh.factory<_i11.ResetPusherChannelsClient>(() =>
      _i11.ResetPusherChannelsClient(
          gh<_i8.PusherChannelsConnectionRepository>()));
  gh.factory<_i12.SettingsNavigator>(
      () => _i12.SettingsNavigator(appNavigator: gh<_i3.AppNavigator>()));
  await gh.lazySingletonAsync<_i13.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i14.SubscribeAndListenToPresenceChannelEvents>(() =>
      _i14.SubscribeAndListenToPresenceChannelEvents(
          gh<_i8.PusherChannelsConnectionRepository>()));
  gh.factory<_i15.TriggerClientEventOnPresenceChannel>(() =>
      _i15.TriggerClientEventOnPresenceChannel(
          gh<_i8.PusherChannelsConnectionRepository>()));
  gh.factory<_i16.ChatListCubit>(() => _i16.ChatListCubit(
        gh<_i10.ResetPresenceChannelState>(),
        gh<_i14.SubscribeAndListenToPresenceChannelEvents>(),
      ));
  gh.factory<_i17.ChatMessageTriggerCubit>(() => _i17.ChatMessageTriggerCubit(
      gh<_i15.TriggerClientEventOnPresenceChannel>()));
  gh.factory<_i18.ConnectPusherChannelsClient>(() =>
      _i18.ConnectPusherChannelsClient(
          gh<_i8.PusherChannelsConnectionRepository>()));
  gh.factory<_i19.ListenForPusherChannelsClientConnection>(() =>
      _i19.ListenForPusherChannelsClientConnection(
          gh<_i8.PusherChannelsConnectionRepository>()));
  gh.factory<_i20.PusherChannelsConnectionCubit>(
      () => _i20.PusherChannelsConnectionCubit(
            gh<_i18.ConnectPusherChannelsClient>(),
            gh<_i11.ResetPusherChannelsClient>(),
            gh<_i19.ListenForPusherChannelsClientConnection>(),
          ));
  gh.factory<_i21.SettingsPreferences>(
      () => _i21.SettingsPreferencesImpl(gh<_i13.SharedPreferences>()));
  gh.factory<_i22.SettingsRepository>(
      () => _i23.SettingsRepositoryImpl(gh<_i21.SettingsPreferences>()));
  gh.factory<_i24.ChatPageModel>(() => _i24.ChatPageModel(
        gh<_i5.ChatNewMessagesButtonVisibilityCubit>(),
        gh<_i20.PusherChannelsConnectionCubit>(),
        gh<_i16.ChatListCubit>(),
        gh<_i17.ChatMessageTriggerCubit>(),
      ));
  gh.factory<_i25.ChatPagePresenter>(
      () => _i25.ChatPagePresenter(gh<_i24.ChatPageModel>()));
  gh.factory<_i26.GetSettingsRecords>(
      () => _i26.GetSettingsRecords(gh<_i22.SettingsRepository>()));
  gh.factory<_i27.SaveLocale>(
      () => _i27.SaveLocale(gh<_i22.SettingsRepository>()));
  gh.factory<_i28.SaveTheme>(
      () => _i28.SaveTheme(gh<_i22.SettingsRepository>()));
  await gh.singletonAsync<_i29.SettingsStoreCubit>(
    () => _i29.SettingsStoreCubit.internal(
      gh<_i26.GetSettingsRecords>(),
      gh<_i27.SaveLocale>(),
      gh<_i28.SaveTheme>(),
    ),
    preResolve: true,
  );
  gh.factory<_i30.SettingsPageModel>(
      () => _i30.SettingsPageModel(gh<_i29.SettingsStoreCubit>()));
  gh.factory<_i31.SettingsPagePresenter>(
      () => _i31.SettingsPagePresenter(gh<_i30.SettingsPageModel>()));
  return getIt;
}

class _$InjectionModule extends _i32.InjectionModule {}
