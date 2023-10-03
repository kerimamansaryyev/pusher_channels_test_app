import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart';
import 'package:pusher_channels_test_app/localization/localization_service.dart';

import '../../../mocks/test_mocks.mocks.dart';

final class _DummyFailure implements Failure {
  const _DummyFailure();

  @override
  Exception? get exception => throw UnimplementedError();

  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}

void main() {
  group('GetSettingsRecords use-case test', () {
    final getIt = GetIt.instance;
    final settingsRepository = MockSettingsRepository();

    setUp(() {
      getIt.reset();
      getIt.registerFactory<SettingsRepository>(() => settingsRepository);
      getIt.registerFactory<GetSettingsRecords>(
        () => GetSettingsRecords(
          getIt(),
        ),
      );
    });

    test(
      'Must return expected locale and expected theme given by the repository',
      () async {
        await getIt.allReady();

        provideDummy<Either<Failure<Exception>, String?>>(
            const Left(_DummyFailure()));

        const expectedLocaleCode = LocalizationService.ruLocaleCode;
        final expectedThemeName = const AppTheme.dark().name;

        when(settingsRepository.getLocaleCode())
            .thenAnswer((_) async => const Right(expectedLocaleCode));
        when(settingsRepository.getThemeName())
            .thenAnswer((_) async => Right(expectedThemeName));

        final getSettingsRecord = getIt<GetSettingsRecords>();

        final eitherResult = await getSettingsRecord();
        final result = eitherResult.tryGetRight();

        expect(eitherResult, isA<Right>());

        if (result != null) {
          expect(result.$1?.name, expectedThemeName);
          expect(result.$2?.languageCode, expectedLocaleCode);
        }
      },
    );

    test(
      'Must return null as locale code if the repository returns an unsupported locale code',
      () async {
        await getIt.allReady();

        provideDummy<Either<Failure<Exception>, String?>>(
            const Left(_DummyFailure()));

        const esLocaleCode = 'es';

        when(settingsRepository.getLocaleCode())
            .thenAnswer((_) async => const Right(esLocaleCode));

        final getSettingsRecord = getIt<GetSettingsRecords>();

        final eitherResult = await getSettingsRecord();
        final result = eitherResult.tryGetRight();

        expect(eitherResult, isA<Right>());

        if (result != null) {
          expect(result.$2?.languageCode, null);
        }
      },
    );

    getIt.reset();
  });
}
