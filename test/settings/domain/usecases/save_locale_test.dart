import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_locale.dart';
import 'package:pusher_channels_test_app/localization/localization_service.dart';

import '../../../mocks/dummy_failure.dart';
import '../../../mocks/test_mocks.mocks.dart';

void main() {
  group(
    'SaveLocale use-case test',
    () {
      final getIt = GetIt.instance;
      final settingsRepository = MockSettingsRepository();

      setUp(() {
        clearInteractions(settingsRepository);
        getIt.reset();
        getIt.registerFactory<SettingsRepository>(() => settingsRepository);
        getIt.registerFactory<GetSettingsRecords>(
          () => GetSettingsRecords(
            getIt(),
          ),
        );
        getIt.registerFactory<SaveLocale>(
          () => SaveLocale(
            getIt(),
          ),
        );
      });

      test(
        'Must save a locale selected by user',
        () async {
          await getIt.allReady();
          provideDummy<Either<Failure<Exception>, String?>>(
            const Left(DummyFailure()),
          );
          provideDummy<Either<Failure<Exception>, void>>(
            const Left(DummyFailure()),
          );

          const userLocaleChoiceCode = LocalizationService.ruLocaleCode;

          String? savedLocaleCode;

          final saveLocale = getIt<SaveLocale>();
          final getSettingsRecord = getIt<GetSettingsRecords>();

          when(settingsRepository.saveLocale(any))
              .thenAnswer((realInvocation) async {
            savedLocaleCode = realInvocation.positionalArguments.first;
            return const Right(null);
          });

          when(settingsRepository.getThemeName()).thenAnswer(
            (realInvocation) async {
              return Right(const AppTheme.dark().name);
            },
          );

          when(settingsRepository.getLocaleCode()).thenAnswer(
            (realInvocation) async {
              return Right(savedLocaleCode as String);
            },
          );

          await saveLocale(
            localeCode: userLocaleChoiceCode,
          );

          final extractedLocale =
              (await getSettingsRecord()).tryGetRight()?.$2?.languageCode;

          expect(extractedLocale, equals(userLocaleChoiceCode));
          verify(settingsRepository.getLocaleCode()).called(1);
          verify(settingsRepository.saveLocale(any)).called(1);
        },
      );
    },
  );
}
