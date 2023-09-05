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
import 'package:shared_preferences/shared_preferences.dart' as _i12;

import '../core/di/injection_module.dart' as _i26;
import '../features/chat/domain/use-cases/reset_presence_channel_state.dart'
    as _i9;
import '../features/chat/domain/use-cases/subscribe_and_listen_to_presence_channel_events.dart'
    as _i13;
import '../features/chat/domain/use-cases/trigger_client_event_on_presence_channel.dart'
    as _i14;
import '../features/chat/presentation/blocs/chat_list_cubit.dart' as _i15;
import '../features/chat/presentation/blocs/chat_message_trigger_cubit.dart'
    as _i16;
import '../features/chat/presentation/blocs/chat_new_messages_button_visibility.dart'
    as _i5;
import '../features/chat/presentation/chat_navigator.dart' as _i4;
import '../features/home/presentation/home_navigator.dart' as _i6;
import '../features/pusher_channels_connection/data/repositories/pusher_channels_connection_repository_impl.dart'
    as _i8;
import '../features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart'
    as _i7;
import '../features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart'
    as _i17;
import '../features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart'
    as _i18;
import '../features/pusher_channels_connection/domain/use-cases/reset_pusher_channels_client.dart'
    as _i10;
import '../features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart'
    as _i19;
import '../features/settings/data/repositories/settings_repository_impl.dart'
    as _i22;
import '../features/settings/data/storages/settings_preferences.dart' as _i20;
import '../features/settings/domain/repositories/settings_repository.dart'
    as _i21;
import '../features/settings/domain/stores/settings_store.dart' as _i25;
import '../features/settings/domain/usecases/get_settings_records.dart' as _i23;
import '../features/settings/domain/usecases/save_settings_records.dart'
    as _i24;
import '../features/settings/presentation/settings_navigator.dart' as _i11;
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
  gh.lazySingleton<_i7.PusherChannelsConnectionRepository>(
      () => _i8.PusherChannelsConnectionRepositoryImpl());
  gh.factory<_i9.ResetPresenceChannelState>(() => _i9.ResetPresenceChannelState(
      gh<_i7.PusherChannelsConnectionRepository>()));
  gh.factory<_i10.ResetPusherChannelsClient>(() =>
      _i10.ResetPusherChannelsClient(
          gh<_i7.PusherChannelsConnectionRepository>()));
  gh.factory<_i11.SettingsNavigator>(
      () => _i11.SettingsNavigator(appNavigator: gh<_i3.AppNavigator>()));
  await gh.lazySingletonAsync<_i12.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i13.SubscribeAndListenToPresenceChannelEvents>(() =>
      _i13.SubscribeAndListenToPresenceChannelEvents(
          gh<_i7.PusherChannelsConnectionRepository>()));
  gh.factory<_i14.TriggerClientEventOnPresenceChannel>(() =>
      _i14.TriggerClientEventOnPresenceChannel(
          gh<_i7.PusherChannelsConnectionRepository>()));
  gh.factory<_i15.ChatListCubit>(() => _i15.ChatListCubit(
        gh<_i9.ResetPresenceChannelState>(),
        gh<_i13.SubscribeAndListenToPresenceChannelEvents>(),
      ));
  gh.factory<_i16.ChatMessageTriggerCubit>(() => _i16.ChatMessageTriggerCubit(
      gh<_i14.TriggerClientEventOnPresenceChannel>()));
  gh.factory<_i17.ConnectPusherChannelsClient>(() =>
      _i17.ConnectPusherChannelsClient(
          gh<_i7.PusherChannelsConnectionRepository>()));
  gh.factory<_i18.ListenForPusherChannelsClientConnection>(() =>
      _i18.ListenForPusherChannelsClientConnection(
          gh<_i7.PusherChannelsConnectionRepository>()));
  gh.factory<_i19.PusherChannelsConnectionCubit>(
      () => _i19.PusherChannelsConnectionCubit(
            gh<_i17.ConnectPusherChannelsClient>(),
            gh<_i10.ResetPusherChannelsClient>(),
            gh<_i18.ListenForPusherChannelsClientConnection>(),
          ));
  gh.factory<_i20.SettingsPreferences>(
      () => _i20.SettingsPreferencesImpl(gh<_i12.SharedPreferences>()));
  gh.factory<_i21.SettingsRepository>(
      () => _i22.SettingsRepositoryImpl(gh<_i20.SettingsPreferences>()));
  gh.factory<_i23.GetSettingsRecords>(
      () => _i23.GetSettingsRecords(gh<_i21.SettingsRepository>()));
  gh.factory<_i24.SaveSettingsRecords>(
      () => _i24.SaveSettingsRecords(gh<_i21.SettingsRepository>()));
  await gh.singletonAsync<_i25.SettingsStoreCubit>(
    () => _i25.SettingsStoreCubit.internal(
      gh<_i23.GetSettingsRecords>(),
      gh<_i24.SaveSettingsRecords>(),
    ),
    preResolve: true,
  );
  return getIt;
}

class _$InjectionModule extends _i26.InjectionModule {}
