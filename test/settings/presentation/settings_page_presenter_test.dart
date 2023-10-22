import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/settings/domain/stores/settings_store_cubit.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_locale.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_theme.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/pages/settings_page/settings_page_model.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/pages/settings_page/settings_page_presenter.dart';
import 'package:pusher_channels_test_app/features/settings/presentation/pages/settings_page/settings_page_view.dart';
import 'package:pusher_channels_test_app/localization/localization_service.dart';

import '../../mocks/dummy_failure.dart';
import '../../mocks/test_mocks.mocks.dart';

final class _TestSettingsPageView implements SettingsPageView {
  final BlocBase<SettingsStoreState> readSettingsStoreCubit;

  _TestSettingsPageView(this.readSettingsStoreCubit);
}

final _getIt = GetIt.instance;

Future<void> _inject({
  required MockGetSettingsRecords getSettingsRecords,
  required MockSaveLocale saveLocale,
  required MockSaveTheme saveTheme,
}) {
  _getIt.registerSingleton<GetSettingsRecords>(
    getSettingsRecords,
  );

  _getIt.registerSingleton<SaveLocale>(saveLocale);
  _getIt.registerSingleton<SaveTheme>(saveTheme);

  _getIt.registerSingletonAsync<SettingsStoreCubit>(
    () => SettingsStoreCubit.internal(
      _getIt(),
      _getIt(),
      _getIt(),
    ),
  );
  _getIt.registerFactory<SettingsPageModel>(
    () => SettingsPageModel(_getIt()),
  );
  _getIt.registerFactory(
    () => SettingsPagePresenter(
      _getIt(),
    ),
  );
  return _getIt.allReady();
}

void main() {
  group(
    'Settings page presenter test',
    () {
      setUp(
        () {
          _getIt.reset();
        },
      );

      test(
        'SettingsStoreCubit must be initialized with values from GetSettingsRecord',
        () async {
          final getSettingsRecords = MockGetSettingsRecords();
          provideDummyBuilder<Either<Failure<Exception>, SettingsRecord>>(
            (parent, invocation) => const Left(
              DummyFailure(),
            ),
          );
          const initialLocale = LocalizationService.tkLocale;
          const initialTheme = AppTheme.dark();
          when(getSettingsRecords.call()).thenAnswer(
            (realInvocation) async => const Right(
              (initialTheme, initialLocale),
            ),
          );
          await _inject(
            getSettingsRecords: getSettingsRecords,
            saveLocale: MockSaveLocale(),
            saveTheme: MockSaveTheme(),
          );
          final presenter = _getIt<SettingsPagePresenter>();
          expect(
            presenter.readSettingsStoreCubit.state.locale,
            equals(initialLocale),
          );
          expect(
            presenter.readSettingsStoreCubit.state.theme,
            equals(initialTheme),
          );
        },
      );
      test(
        'SettingsStoreCubit of SettingsPageModel will fire events when presenter initiates changes and saves data',
        () async {
          final getSettingsRecords = MockGetSettingsRecords();
          final saveLocale = MockSaveLocale();
          final saveTheme = MockSaveTheme();

          String? savedLocaleCode;
          String? savedThemeName;

          provideDummyBuilder<Either<Failure<Exception>, SettingsRecord>>(
            (parent, invocation) => const Left(
              DummyFailure(),
            ),
          );
          provideDummyBuilder<Either<Failure<Exception>, void>>(
            (parent, invocation) => const Left(
              DummyFailure(),
            ),
          );

          when(getSettingsRecords.call()).thenAnswer(
            (realInvocation) async => const Right(
              (null, null),
            ),
          );

          when(
            saveLocale.call(
              localeCode: anyNamed('localeCode'),
            ),
          ).thenAnswer(
            (realInvocation) async {
              savedLocaleCode = realInvocation.namedArguments[#localeCode];
              return const Right(null);
            },
          );

          when(
            saveTheme.call(
              themeName: anyNamed('themeName'),
            ),
          ).thenAnswer(
            (realInvocation) async {
              savedThemeName = realInvocation.namedArguments[#themeName];
              return const Right(null);
            },
          );

          await _inject(
            getSettingsRecords: getSettingsRecords,
            saveLocale: saveLocale,
            saveTheme: saveTheme,
          );
          final presenter = _getIt<SettingsPagePresenter>();
          final view = _TestSettingsPageView(
            presenter.readSettingsStoreCubit,
          );
          presenter.bindView(view);

          const localeToBeSet = LocalizationService.tkLocale;
          const themeToBeSet = AppTheme.dark();

          unawaited(
            expectLater(
              view.readSettingsStoreCubit.stream,
              emitsInOrder(
                [
                  equals(
                    const SettingsStoreState(
                      locale: localeToBeSet,
                      theme: null,
                    ),
                  ),
                  equals(
                    const SettingsStoreState(
                      locale: localeToBeSet,
                      theme: themeToBeSet,
                    ),
                  ),
                  emitsDone,
                ],
              ),
            ),
          );

          expect(
            view.readSettingsStoreCubit.state.locale,
            equals(
              LocalizationService.fallbackLocale,
            ),
          );

          presenter.chooseLanguage(
            localeToBeSet,
          );
          presenter.toggleTheme(
            true,
          );

          presenter.dispose();

          await _getIt<SettingsStoreCubit>().close();
          await Future.delayed(const Duration(seconds: 1));

          expect(
            view.readSettingsStoreCubit.state.locale.languageCode,
            equals(
              savedLocaleCode,
            ),
          );

          expect(
            view.readSettingsStoreCubit.state.theme?.name,
            equals(
              savedThemeName,
            ),
          );
        },
      );
    },
  );
}
