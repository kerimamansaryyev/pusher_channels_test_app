// Mocks generated by Mockito 5.4.2 from annotations
// in pusher_channels_test_app/test/mocks/test_mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:ui' as _i11;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i6;
import 'package:pusher_channels_test_app/core/domain/failure.dart' as _i5;
import 'package:pusher_channels_test_app/core/utils/either/either.dart' as _i4;
import 'package:pusher_channels_test_app/core/utils/theme/app_theme.dart'
    as _i10;
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart'
    as _i13;
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart'
    as _i14;
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart'
    as _i12;
import 'package:pusher_channels_test_app/features/settings/domain/repositories/settings_repository.dart'
    as _i2;
import 'package:pusher_channels_test_app/features/settings/domain/usecases/get_settings_records.dart'
    as _i9;
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_locale.dart'
    as _i7;
import 'package:pusher_channels_test_app/features/settings/domain/usecases/save_theme.dart'
    as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SettingsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingsRepository extends _i1.Mock
    implements _i2.SettingsRepository {
  @override
  _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>> getThemeName() =>
      (super.noSuchMethod(
        Invocation.method(
          #getThemeName,
          [],
        ),
        returnValue:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, String?>>(
          this,
          Invocation.method(
            #getThemeName,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, String?>>(
          this,
          Invocation.method(
            #getThemeName,
            [],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>> getLocaleCode() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLocaleCode,
          [],
        ),
        returnValue:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, String?>>(
          this,
          Invocation.method(
            #getLocaleCode,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, String?>>(
          this,
          Invocation.method(
            #getLocaleCode,
            [],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure<Exception>, String?>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure<Exception>, void>> saveTheme(
          String? themeName) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveTheme,
          [themeName],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
            _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #saveTheme,
            [themeName],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #saveTheme,
            [themeName],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure<Exception>, void>> saveLocale(
          String? localeCode) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveLocale,
          [localeCode],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
            _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #saveLocale,
            [localeCode],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #saveLocale,
            [localeCode],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>);
}

/// A class which mocks [SaveLocale].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveLocale extends _i1.Mock implements _i7.SaveLocale {
  @override
  _i3.Future<_i4.Either<_i5.Failure<Exception>, void>> call(
          {required String? localeCode}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#localeCode: localeCode},
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
            _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #call,
            [],
            {#localeCode: localeCode},
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #call,
            [],
            {#localeCode: localeCode},
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>);
}

/// A class which mocks [SaveTheme].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTheme extends _i1.Mock implements _i8.SaveTheme {
  @override
  _i3.Future<_i4.Either<_i5.Failure<Exception>, void>> call(
          {required String? themeName}) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
          {#themeName: themeName},
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
            _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #call,
            [],
            {#themeName: themeName},
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>.value(
                _i6.dummyValue<_i4.Either<_i5.Failure<Exception>, void>>(
          this,
          Invocation.method(
            #call,
            [],
            {#themeName: themeName},
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure<Exception>, void>>);
}

/// A class which mocks [GetSettingsRecords].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSettingsRecords extends _i1.Mock
    implements _i9.GetSettingsRecords {
  @override
  _i3.Future<
      _i4.Either<_i5.Failure<Exception>,
          (_i10.AppTheme?, _i11.Locale?)>> call() => (super.noSuchMethod(
        Invocation.method(
          #call,
          [],
        ),
        returnValue: _i3.Future<
            _i4.Either<_i5.Failure<Exception>,
                (_i10.AppTheme?, _i11.Locale?)>>.value(_i6.dummyValue<
            _i4.Either<_i5.Failure<Exception>, (_i10.AppTheme?, _i11.Locale?)>>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
        returnValueForMissingStub: _i3.Future<
            _i4.Either<_i5.Failure<Exception>,
                (_i10.AppTheme?, _i11.Locale?)>>.value(_i6.dummyValue<
            _i4.Either<_i5.Failure<Exception>, (_i10.AppTheme?, _i11.Locale?)>>(
          this,
          Invocation.method(
            #call,
            [],
          ),
        )),
      ) as _i3.Future<
          _i4.Either<_i5.Failure<Exception>, (_i10.AppTheme?, _i11.Locale?)>>);
}

/// A class which mocks [PusherChannelsConnectionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPusherChannelsConnectionRepository extends _i1.Mock
    implements _i12.PusherChannelsConnectionRepository {
  @override
  _i3.Stream<_i13.PusherChannelsConnectionResult> onConnectionChanged() =>
      (super.noSuchMethod(
        Invocation.method(
          #onConnectionChanged,
          [],
        ),
        returnValue: _i3.Stream<_i13.PusherChannelsConnectionResult>.empty(),
        returnValueForMissingStub:
            _i3.Stream<_i13.PusherChannelsConnectionResult>.empty(),
      ) as _i3.Stream<_i13.PusherChannelsConnectionResult>);

  @override
  _i3.Stream<_i14.PusherChannelsEventEntity> onPresenceChannelEvent({
    required String? channelName,
    String? eventNameToBind,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #onPresenceChannelEvent,
          [],
          {
            #channelName: channelName,
            #eventNameToBind: eventNameToBind,
          },
        ),
        returnValue: _i3.Stream<_i14.PusherChannelsEventEntity>.empty(),
        returnValueForMissingStub:
            _i3.Stream<_i14.PusherChannelsEventEntity>.empty(),
      ) as _i3.Stream<_i14.PusherChannelsEventEntity>);

  @override
  _i4.Either<_i5.Failure<Exception>, _i14.PusherChannelsUserMessageEventEntity>
      triggerClientEventOnPresenceChannel({
    required String? message,
    required String? channelName,
    required String? eventName,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #triggerClientEventOnPresenceChannel,
              [],
              {
                #message: message,
                #channelName: channelName,
                #eventName: eventName,
              },
            ),
            returnValue: _i6.dummyValue<
                _i4.Either<_i5.Failure<Exception>,
                    _i14.PusherChannelsUserMessageEventEntity>>(
              this,
              Invocation.method(
                #triggerClientEventOnPresenceChannel,
                [],
                {
                  #message: message,
                  #channelName: channelName,
                  #eventName: eventName,
                },
              ),
            ),
            returnValueForMissingStub: _i6.dummyValue<
                _i4.Either<_i5.Failure<Exception>,
                    _i14.PusherChannelsUserMessageEventEntity>>(
              this,
              Invocation.method(
                #triggerClientEventOnPresenceChannel,
                [],
                {
                  #message: message,
                  #channelName: channelName,
                  #eventName: eventName,
                },
              ),
            ),
          ) as _i4.Either<_i5.Failure<Exception>,
              _i14.PusherChannelsUserMessageEventEntity>);

  @override
  void resetPresenceChannelState({required String? channelName}) =>
      super.noSuchMethod(
        Invocation.method(
          #resetPresenceChannelState,
          [],
          {#channelName: channelName},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetToDefaults() => super.noSuchMethod(
        Invocation.method(
          #resetToDefaults,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void connect() => super.noSuchMethod(
        Invocation.method(
          #connect,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
