import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pusher_channels_test_app/src/localization/localization_service.dart';

extension LocalizationTranslationExtension on BuildContext {
  AppLocalizations get translation {
    final translation = LocalizationService.translation(this);
    assert(translation != null);
    return translation!;
  }

  MaterialLocalizations get materialTranslation =>
      MaterialLocalizations.of(this);
}
