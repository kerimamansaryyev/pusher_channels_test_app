import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart';
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart';
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_theme.dart';

import '../../../mocks/test_mocks.mocks.dart';

final class _DummyFailure implements Failure {
  const _DummyFailure();

  @override
  Exception? get exception => throw UnimplementedError();

  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}

void main() {
  group(
    'SaveTheme use-case test',
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
        getIt.registerFactory<SaveTheme>(
          () => SaveTheme(
            getIt(),
          ),
        );
      });

      test(
        'Must save a theme selected by user',
        () async {
          await getIt.allReady();
          provideDummy<Either<Failure<Exception>, String?>>(
            const Left(_DummyFailure()),
          );
          provideDummy<Either<Failure<Exception>, void>>(
            const Left(_DummyFailure()),
          );

          final userThemeChoiceName = const AppTheme.dark().name;

          String? savedThemeName;

          final saveTheme = getIt<SaveTheme>();
          final getSettingsRecord = getIt<GetSettingsRecords>();

          when(settingsRepository.saveTheme(any))
              .thenAnswer((realInvocation) async {
            savedThemeName = realInvocation.positionalArguments.first;
            return const Right(null);
          });

          when(settingsRepository.getLocaleCode()).thenAnswer(
            (realInvocation) async {
              return const Right('ru');
            },
          );

          when(settingsRepository.getThemeName()).thenAnswer(
            (realInvocation) async {
              return Right(savedThemeName as String);
            },
          );

          await saveTheme(
            themeName: userThemeChoiceName,
          );

          final extractedThemeName =
              (await getSettingsRecord()).tryGetRight()?.$1?.name;

          expect(extractedThemeName, equals(userThemeChoiceName));
          verify(settingsRepository.getThemeName()).called(1);
          verify(settingsRepository.saveTheme(any)).called(1);
        },
      );
    },
  );
}
