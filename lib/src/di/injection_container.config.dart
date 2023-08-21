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
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../core/di/injection_module.dart' as _i12;
import '../features/home/presentation/home_navigator.dart' as _i4;
import '../features/settings/data/repositories/settings_repository_impl.dart'
    as _i8;
import '../features/settings/data/storages/settings_preferences.dart' as _i6;
import '../features/settings/domain/repositories/settings_repository.dart'
    as _i7;
import '../features/settings/domain/stores/settings_store.dart' as _i11;
import '../features/settings/domain/usecases/get_settings_records.dart' as _i9;
import '../features/settings/domain/usecases/save_settings_records.dart'
    as _i10;
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
  await gh.lazySingletonAsync<_i5.SharedPreferences>(
    () => injectionModule.sharedPreferences,
    preResolve: true,
  );
  gh.factory<_i6.SettingsPreferences>(
      () => _i6.SettingsPreferencesImpl(gh<_i5.SharedPreferences>()));
  gh.factory<_i7.SettingsRepository>(
      () => _i8.SettingsRepositoryImpl(gh<_i6.SettingsPreferences>()));
  gh.factory<_i9.GetSettingsRecords>(
      () => _i9.GetSettingsRecords(gh<_i7.SettingsRepository>()));
  gh.factory<_i10.SaveSettingsRecords>(
      () => _i10.SaveSettingsRecords(gh<_i7.SettingsRepository>()));
  await gh.singletonAsync<_i11.SettingsStoreCubit>(
    () => _i11.SettingsStoreCubit.internal(
      gh<_i9.GetSettingsRecords>(),
      gh<_i10.SaveSettingsRecords>(),
    ),
    preResolve: true,
  );
  return getIt;
}

class _$InjectionModule extends _i12.InjectionModule {}
