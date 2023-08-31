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
import 'package:shared_preferences/shared_preferences.dart' as _i9;

import '../core/di/injection_module.dart' as _i19;
import '../features/home/presentation/home_navigator.dart' as _i4;
import '../features/pusher_channels_connection/data/repositories/pusher_channels_connection_repository_impl.dart'
    as _i6;
import '../features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart'
    as _i5;
import '../features/pusher_channels_connection/domain/use-cases/connect_pusher_channels_client.dart'
    as _i10;
import '../features/pusher_channels_connection/domain/use-cases/listen_for_pusher_channels_client_connection.dart'
    as _i11;
import '../features/pusher_channels_connection/domain/use-cases/reset_pusher_channels_client.dart'
    as _i7;
import '../features/pusher_channels_connection/presentation/blocs/pusher_channels_connection_cubit.dart'
    as _i12;
import '../features/settings/data/repositories/settings_repository_impl.dart'
    as _i15;
import '../features/settings/data/storages/settings_preferences.dart' as _i13;
import '../features/settings/domain/repositories/settings_repository.dart'
    as _i14;
import '../features/settings/domain/stores/settings_store.dart' as _i18;
import '../features/settings/domain/usecases/get_settings_records.dart' as _i16;
import '../features/settings/domain/usecases/save_settings_records.dart'
    as _i17;
import '../features/settings/presentation/settings_navigator.dart' as _i8;
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
  gh.factory<_i4.HomeNavigator>(
      () => _i4.HomeNavigator(appNavigator: gh<_i3.AppNavigator>()));
  gh.lazySingleton<_i5.PusherChannelsConnectionRepository>(
      () => _i6.PusherChannelsConnectionRepositoryImpl());
  gh.factory<_i7.ResetPusherChannelsClient>(() => _i7.ResetPusherChannelsClient(
      gh<_i5.PusherChannelsConnectionRepository>()));
  gh.factory<_i8.SettingsNavigator>(
      () => _i8.SettingsNavigator(appNavigator: gh<_i3.AppNavigator>()));
  await gh.lazySingletonAsync<_i9.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i10.ConnectPusherChannelsClient>(() =>
      _i10.ConnectPusherChannelsClient(
          gh<_i5.PusherChannelsConnectionRepository>()));
  gh.factory<_i11.ListenForPusherChannelsClientConnection>(() =>
      _i11.ListenForPusherChannelsClientConnection(
          gh<_i5.PusherChannelsConnectionRepository>()));
  gh.factory<_i12.PusherChannelsConnectionCubit>(
      () => _i12.PusherChannelsConnectionCubit(
            gh<_i10.ConnectPusherChannelsClient>(),
            gh<_i7.ResetPusherChannelsClient>(),
            gh<_i11.ListenForPusherChannelsClientConnection>(),
          ));
  gh.factory<_i13.SettingsPreferences>(
      () => _i13.SettingsPreferencesImpl(gh<_i9.SharedPreferences>()));
  gh.factory<_i14.SettingsRepository>(
      () => _i15.SettingsRepositoryImpl(gh<_i13.SettingsPreferences>()));
  gh.factory<_i16.GetSettingsRecords>(
      () => _i16.GetSettingsRecords(gh<_i14.SettingsRepository>()));
  gh.factory<_i17.SaveSettingsRecords>(
      () => _i17.SaveSettingsRecords(gh<_i14.SettingsRepository>()));
  await gh.singletonAsync<_i18.SettingsStoreCubit>(
    () => _i18.SettingsStoreCubit.internal(
      gh<_i16.GetSettingsRecords>(),
      gh<_i17.SaveSettingsRecords>(),
    ),
    preResolve: true,
  );
  return getIt;
}

class _$InjectionModule extends _i19.InjectionModule {}
