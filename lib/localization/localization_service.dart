import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pusher_channels_test_app/localization/tk_intl.dart';

/// An abstract singleton class that holds [delegates] and returns [AppLocalizations] from [translation] method.
abstract class LocalizationService {
  static AppLocalizations? _testLocalizations;

  static const delegates = <LocalizationsDelegate>[
    AppLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    TkMaterialLocalizations.delegate,
    CupertinoLocalizationTk.delegate
  ];

  static const supportedLocales = [
    ruLocale,
    tkLocale,
    enLocale,
  ];

  static const Locale fallbackLocale = Locale(enLocaleCode);

  static const tkLocaleCode = 'tk';

  static const ruLocaleCode = 'ru';

  static const enLocaleCode = 'en';

  static const tkLocale = Locale(tkLocaleCode);
  static const ruLocale = Locale(ruLocaleCode);
  static const enLocale = Locale(enLocaleCode);

  @visibleForTesting
  static Future<void> setTestLocalizations(Locale locale) async {
    _testLocalizations = await AppLocalizations.delegate.load(locale);
  }

  /// Must be called only under the context of [MaterialApp], [CupertinoApp]
  static AppLocalizations? translation(BuildContext context) =>
      _testLocalizations ?? AppLocalizations.of(context);
}
