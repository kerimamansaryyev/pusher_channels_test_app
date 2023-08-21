// ignore_for_file: always_put_required_named_parameters_first

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbols.dart' as intl;
import 'package:intl/date_symbol_data_custom.dart' as date_symbol_data_custom;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const _tkDatePatterns = {
  'd': 'd',
  'E': 'ccc',
  'EEEE': 'cccc',
  'LLL': 'LLL',
  'LLLL': 'LLLL',
  'M': 'L',
  'Md': 'dd/MM',
  'MEd': 'EEE, dd/MM',
  'MMM': 'LLL',
  'MMMd': 'd MMM',
  'MMMEd': 'EEE, d MMM',
  'MMMM': 'LLLL',
  'MMMMd': 'd MMMM',
  'MMMMEEEEd': 'EEEE, d MMMM',
  'QQQ': 'QQQ',
  'QQQQ': 'QQQQ',
  'y': 'y',
  'yM': 'MM/y',
  'yMd': 'dd/MM/y',
  'yMEd': 'EEE, dd/MM/y',
  'yMMM': 'MMM y',
  'yMMMd': 'd MMM y',
  'yMMMEd': 'EEE, d MMM y',
  'yMMMM': 'MMMM y',
  'yMMMMd': 'd MMMM y',
  'yMMMMEEEEd': 'EEEE, d MMMM y',
  'yQQQ': 'QQQ y',
  'yQQQQ': 'QQQQ y',
  'H': 'HH',
  'Hm': 'HH:mm',
  'Hms': 'HH:mm:ss',
  'j': 'HH',
  'jm': 'HH:mm',
  'jms': 'HH:mm:ss',
  'jmv': 'HH:mm v',
  'jmz': 'HH:mm z',
  'jz': 'HH z',
  'm': 'm',
  'ms': 'mm:ss',
  's': 's',
  'v': 'v',
  'z': 'z',
  'zzzz': 'zzzz',
  'ZZZZ': 'ZZZZ'
};

const _tkSymbols = {
  'NAME': 'tk',
  'ERAS': ['BC', 'AD'],
  'ERANAMES': ['Before Christ', 'Anno Domini'],
  'NARROWMONTHS': ['Ý', 'F', 'M', 'A', 'M', 'I', 'I', 'A', 'S', 'O', 'N', 'D'],
  'STANDALONENARROWMONTHS': [
    'Ý',
    'F',
    'M',
    'A',
    'M',
    'I',
    'I',
    'A',
    'S',
    'O',
    'N',
    'D'
  ],
  'MONTHS': [
    'Ýanwar',
    'Fewral',
    'Mart',
    'Aprel',
    'Maý',
    'Iýun',
    'Iýul',
    'Awgust',
    'Sentýabr',
    'Oktýabr',
    'Noýabr',
    'Dekabr'
  ],
  'STANDALONEMONTHS': [
    'Ýanwar',
    'Fewral',
    'Mart',
    'Aprel',
    'Maý',
    'Iýun',
    'Iýul',
    'Awgust',
    'Sentýabr',
    'Oktýabr',
    'Noýabr',
    'Dekabr'
  ],
  'SHORTMONTHS': [
    'Ýan',
    'Few',
    'Mar',
    'Apr',
    'Maý',
    'Iýu',
    'Iýl',
    'Awg',
    'Sen',
    'Okt',
    'Noý',
    'Dek'
  ],
  'STANDALONESHORTMONTHS': [
    'Ýan',
    'Few',
    'Mar',
    'Apr',
    'Maý',
    'Iýu',
    'Iýl',
    'Awg',
    'Sen',
    'Okt',
    'Noý',
    'Dek'
  ],
  'WEEKDAYS': [
    'Ýekşenbe',
    'Duşenbe',
    'Sişenbe',
    'Çarşenbe',
    'Penşenbe',
    'Anna',
    'Şenbe'
  ],
  'STANDALONEWEEKDAYS': [
    'Ýekşenbe',
    'Duşenbe',
    'Sişenbe',
    'Çarşenbe',
    'Penşenbe',
    'Anna',
    'Şenbe'
  ],
  'SHORTWEEKDAYS': ['Ýek', 'Duş', 'Siş', 'Çar', 'Pen', 'Ann', 'Şen'],
  'STANDALONESHORTWEEKDAYS': ['Ýek', 'Duş', 'Siş', 'Çar', 'Pen', 'Ann', 'Şen'],
  'NARROWWEEKDAYS': ['Ý', 'D', 'S', 'Ç', 'P', 'A', 'Ş'],
  'STANDALONENARROWWEEKDAYS': ['Ý', 'D', 'S', 'Ç', 'P', 'A', 'Ş'],
  'SHORTQUARTERS': ['K1', 'K2', 'K3', 'K4'],
  'QUARTERS': [
    '1-nji kwartal',
    '2-nji kwartal',
    '3-nji kwartal',
    '4-nji kwartal'
  ],
  'AMPMS': ['am', 'pm'],
  'DATEFORMATS': ['EEEE, d MMMM y', 'd MMMM y', 'd MMM y', 'dd/MM/y'],
  'TIMEFORMATS': ['HH:mm:ss zzzz', 'HH:mm:ss z', 'HH:mm:ss', 'HH:mm'],
  'AVAILABLEFORMATS': null,
  'FIRSTDAYOFWEEK': 0,
  'WEEKENDRANGE': [6],
  'FIRSTWEEKCUTOFFDAY': 3,
  'DATETIMEFORMATS': ['{1}, {0}', '{1}, {0}', '{1}, {0}', '{1}, {0}']
};

class _TkMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _TkMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tk';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());

    // The locale (in this case `nn`) needs to be initialized into the custom
    // date symbols and patterns setup that Flutter uses.
    date_symbol_data_custom.initializeDateFormattingCustom(
      locale: localeName,
      patterns: _tkDatePatterns,
      symbols: intl.DateSymbols.deserializeFromMap(_tkSymbols),
    );

    return SynchronousFuture<MaterialLocalizations>(
      TkMaterialLocalizations(
        localeName: localeName,
        // The `intl` library's NumberFormat class is generated from CLDR data
        // (see https://github.com/dart-lang/intl/blob/master/lib/number_symbols_data.dart).
        // Unfortunately, there is no way to use a locale that isn't defined in
        // this map and the only way to work around this is to use a listed
        // locale's NumberFormat symbols. So, here we use the number formats
        // for 'en' instead.
        decimalFormat: intl.NumberFormat('#,##0.###', 'en'),
        twoDigitZeroPaddedFormat: intl.NumberFormat('00', 'en'),
        // DateFormat here will use the symbols and patterns provided in the
        // `date_symbol_data_custom.initializeDateFormattingCustom` call above.
        // However, an alternative is to simply use a supported locale's
        // DateFormat symbols, similar to NumberFormat above.
        fullYearFormat: intl.DateFormat('y', localeName),
        compactDateFormat: intl.DateFormat('yMd', localeName),
        shortDateFormat: intl.DateFormat('yMMMd', localeName),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', localeName),
        longDateFormat: intl.DateFormat('EEEE, MMMM d, y', localeName),
        yearMonthFormat: intl.DateFormat('MMMM y', localeName),
        shortMonthDayFormat: intl.DateFormat('MMM d'),
      ),
    );
  }

  @override
  bool shouldReload(_TkMaterialLocalizationsDelegate old) => false;
}
// #enddocregion Delegate

/// A custom set of localizations for the 'nn' locale. In this example, only
/// the value for openAppDrawerTooltip was modified to use a custom message as
/// an example. Everything else uses the American English (en) messages
/// and formatting.
class TkMaterialLocalizations extends GlobalMaterialLocalizations {
  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _TkMaterialLocalizationsDelegate();

  const TkMaterialLocalizations({
    String localeName = 'tk',
    required intl.DateFormat fullYearFormat,
    required intl.DateFormat compactDateFormat,
    required intl.DateFormat shortDateFormat,
    required intl.DateFormat mediumDateFormat,
    required intl.DateFormat longDateFormat,
    required intl.DateFormat yearMonthFormat,
    required intl.DateFormat shortMonthDayFormat,
    required intl.NumberFormat decimalFormat,
    required intl.NumberFormat twoDigitZeroPaddedFormat,
  }) : super(
          localeName: localeName,
          fullYearFormat: fullYearFormat,
          compactDateFormat: compactDateFormat,
          shortDateFormat: shortDateFormat,
          mediumDateFormat: mediumDateFormat,
          longDateFormat: longDateFormat,
          yearMonthFormat: yearMonthFormat,
          shortMonthDayFormat: shortMonthDayFormat,
          decimalFormat: decimalFormat,
          twoDigitZeroPaddedFormat: twoDigitZeroPaddedFormat,
        );

// #docregion Getters
  @override
  String get moreButtonTooltip => r'Giňişleýin';

  @override
  String get firstPageTooltip => 'Birinji sahypa';

  @override
  String get lastPageTooltip => 'Soňky sahypa';

  @override
  String get aboutListTileTitleRaw => r'$applicationName hakda';

  @override
  String get alertDialogLabel => r'Üns beriň';
// #enddocregion Getters

  @override
  String get anteMeridiemAbbreviation => r'AM';

  @override
  String get backButtonTooltip => r'Dolan';

  @override
  String get cancelButtonLabel => r'ÖÇÜR';

  @override
  String get closeButtonLabel => r'ÝAPMAK';

  @override
  String get closeButtonTooltip => r'Ýapmak';

  @override
  String get collapsedIconTapHint => r'Giňelt';

  @override
  String get continueButtonLabel => r'DOWAM ET';

  @override
  String get copyButtonLabel => r'GÖÇÜR';

  @override
  String get cutButtonLabel => r'KES';

  @override
  String get deleteButtonTooltip => r'Poz';

  @override
  String get dialogLabel => r'Dialog';

  @override
  String get drawerLabel => r'Nawigasiýa menýusy';

  @override
  String get expandedIconTapHint => r'Kiçelt';

  @override
  String get hideAccountsLabel => r'Akkaundy gizle';

  @override
  String get licensesPageTitle => r'Lisenziýalar';

  @override
  String get modalBarrierDismissLabel => r'Öçür';

  @override
  String get nextMonthTooltip => r'Indiki aý';

  @override
  String get nextPageTooltip => r'Indiki sahypa';

  @override
  String get okButtonLabel => r'OK';

  @override
  // A custom drawer tooltip message.
  String get openAppDrawerTooltip => r'Custom Navigation Menu Tooltip';

// #docregion Raw
  @override
  String get pageRowsInfoTitleRaw => r'$firstRow–$lastRow of $rowCount';

  @override
  String get pageRowsInfoTitleApproximateRaw =>
      r'$firstRow–$lastRow of about $rowCount';
// #enddocregion Raw

  @override
  String get pasteButtonLabel => r'GIRIZ';

  @override
  String get popupMenuLabel => r'Popup menýu';

  @override
  String get postMeridiemAbbreviation => r'PM';

  @override
  String get previousMonthTooltip => r'Öňki aý';

  @override
  String get previousPageTooltip => r'Öňki sahypa';

  @override
  String get refreshIndicatorSemanticLabel => r'Täzele';

  @override
  String? get remainingTextFieldCharacterCountFew => null;

  @override
  String? get remainingTextFieldCharacterCountMany => null;

  @override
  String get remainingTextFieldCharacterCountOne => r'1 harp galdy';

  @override
  String get remainingTextFieldCharacterCountOther =>
      r'$remainingCount harplar galdy';

  @override
  String? get remainingTextFieldCharacterCountTwo => null;

  @override
  String get remainingTextFieldCharacterCountZero => r'Hiç harp galmady';

  @override
  String get reorderItemDown => r'Aşak geçir';

  @override
  String get reorderItemLeft => r'Çepe geçir';

  @override
  String get reorderItemRight => r'Saga geçir';

  @override
  String get reorderItemToEnd => r'Soňuna geçir';

  @override
  String get reorderItemToStart => r'Başyna geçir';

  @override
  String get reorderItemUp => r'Yokary geçir';

  @override
  String get rowsPerPageTitle => r'Sahypa başyna hatar:';

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get searchFieldLabel => r'Gözle';

  @override
  String get selectAllButtonLabel => r'HEMMESINI SAÝLA';

  @override
  String? get selectedRowCountTitleFew => null;

  @override
  String? get selectedRowCountTitleMany => null;

  @override
  String get selectedRowCountTitleOne => r'1 element saýlandy';

  @override
  String get selectedRowCountTitleOther =>
      r'$selectedRowCount elementler saýlandy';

  @override
  String? get selectedRowCountTitleTwo => null;

  @override
  String get selectedRowCountTitleZero => r'Hiç element saýlanmady';

  @override
  String get showAccountsLabel => r'Akkauntlary aç';

  @override
  String get showMenuTooltip => r'Menýuny aç';

  @override
  String get signedInLabel => r'Ulgamda';

  @override
  String get tabLabelRaw => r'$tabCount içinden $tabIndex tab';

  @override
  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.HH_colon_mm;

  @override
  String get timePickerHourModeAnnouncement => r'Sagady saýlaň';

  @override
  String get timePickerMinuteModeAnnouncement => r'Minudy saýlaň';

  @override
  String get viewLicensesButtonLabel => r'LISENZIÝALARY GÖRKEZ';

  @override
  List<String> get narrowWeekdays =>
      const <String>['Ý', 'D', 'S', 'Ç', 'P', 'A', 'Ş'];

  @override
  int get firstDayOfWeekIndex => 1;

  @override
  String get calendarModeButtonLabel => r'Senenama geç';

  @override
  String get dateHelpText => r'mm/dd/yyyy';

  @override
  String get dateInputLabel => r'Senesini giriziň';

  @override
  String get dateOutOfRangeLabel => r'Aralykdan geçdi.';

  @override
  String get datePickerHelpText => r'SENESINI SAÝLAŇ';

  @override
  String get dateRangeEndDateSemanticLabelRaw => r'Gutarýan sene $fullDate';

  @override
  String get dateRangeEndLabel => r'Gutarýan sene';

  @override
  String get dateRangePickerHelpText => 'SENE ARALYGY';

  @override
  String get dateRangeStartDateSemanticLabelRaw => 'Başlangyç sene \$fullDate';

  @override
  String get dateRangeStartLabel => 'Başlangyç sene';

  @override
  String get dateSeparator => '/';

  @override
  String get dialModeButtonLabel => 'Belgi saýlaýyja geçmek';

  @override
  String get inputDateModeButtonLabel => 'Girizmege geç';

  @override
  String get inputTimeModeButtonLabel => 'Tekst girizmege geç';

  @override
  String get invalidDateFormatLabel => 'Ýalňyş format.';

  @override
  String get invalidDateRangeLabel => 'Ýalňyş format.';

  @override
  String get invalidTimeLabel => 'Dogry wagty giriziň';

  @override
  String get licensesPackageDetailTextOther => '\$licenseCount licenses';

  @override
  String get saveButtonLabel => 'ÝATLA';

  @override
  String get selectYearSemanticsLabel => 'Ýyly saýlaň';

  @override
  String get timePickerDialHelpText => 'WAGTY SAÝLAŇ';

  @override
  String get timePickerHourLabel => 'Sagat';

  @override
  String get timePickerInputHelpText => 'WAGTY GIRIZIŇ';

  @override
  String get timePickerMinuteLabel => 'Minut';

  @override
  String get unspecifiedDate => 'Sene';

  @override
  String get unspecifiedDateRange => 'Sene aralygy';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'AltGr';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get keyboardKeyCapsLock => 'Caps Lock';

  @override
  String get keyboardKeyChannelDown => 'Channel Down';

  @override
  String get keyboardKeyChannelUp => 'Channel Up';

  @override
  String get keyboardKeyControl => 'Ctrl';

  @override
  String get keyboardKeyDelete => 'Del';

  @override
  String get keyboardKeyEject => 'Eject';

  @override
  String get keyboardKeyEnd => 'End';

  @override
  String get keyboardKeyEscape => 'Esc';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Home';

  @override
  String get keyboardKeyInsert => 'Insert';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Command';

  @override
  String get keyboardKeyMetaWindows => 'Win';

  @override
  String get keyboardKeyNumLock => 'Num Lock';

  @override
  String get keyboardKeyNumpad0 => 'Num 0';

  @override
  String get keyboardKeyNumpad1 => 'Num 1';

  @override
  String get keyboardKeyNumpad2 => 'Num 2';

  @override
  String get keyboardKeyNumpad3 => 'Num 3';

  @override
  String get keyboardKeyNumpad4 => 'Num 4';

  @override
  String get keyboardKeyNumpad5 => 'Num 5';

  @override
  String get keyboardKeyNumpad6 => 'Num 6';

  @override
  String get keyboardKeyNumpad7 => 'Num 7';

  @override
  String get keyboardKeyNumpad8 => 'Num 8';

  @override
  String get keyboardKeyNumpad9 => 'Num 9';

  @override
  String get keyboardKeyNumpadAdd => 'Num +';

  @override
  String get keyboardKeyNumpadComma => 'Num ,';

  @override
  String get keyboardKeyNumpadDecimal => 'Num .';

  @override
  String get keyboardKeyNumpadDivide => 'Num /';

  @override
  String get keyboardKeyNumpadEnter => 'Num Enter';

  @override
  String get keyboardKeyNumpadEqual => 'Num =';

  @override
  String get keyboardKeyNumpadMultiply => 'Num *';

  @override
  String get keyboardKeyNumpadParenLeft => 'Num (';

  @override
  String get keyboardKeyNumpadParenRight => 'Num )';

  @override
  String get keyboardKeyNumpadSubtract => 'Num -';

  @override
  String get keyboardKeyPageDown => 'PgDown';

  @override
  String get keyboardKeyPageUp => 'PgUp';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Power Off';

  @override
  String get keyboardKeyPrintScreen => 'Print Screen';

  @override
  String get keyboardKeyScrollLock => 'Scroll Lock';

  @override
  String get keyboardKeySelect => 'Select';

  @override
  String get keyboardKeySpace => 'Space';

  @override
  String get menuBarMenuLabel => 'Menýu';

  @override
  String get bottomSheetLabel => 'Menýu';

  @override
  String get currentDateLabel => 'Şu wagtky sene';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get scrimLabel => 'Maska';

  @override
  String get scrimOnTapHintRaw => r'Ýapmak: $modalRouteContentName';
}

class _TkCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _TkCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'tk';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());

    // The locale (in this case `nn`) needs to be initialized into the custom
    // date symbols and patterns setup that Flutter uses.
    date_symbol_data_custom.initializeDateFormattingCustom(
      locale: localeName,
      patterns: _tkDatePatterns,
      symbols: intl.DateSymbols.deserializeFromMap(_tkSymbols),
    );

    final singleDigitHourFormat = intl.DateFormat('HH', localeName);
    final singleDigitMinuteFormat = intl.DateFormat.m(localeName);
    final singleDigitSecondFormat = intl.DateFormat.s(localeName);
    final dayFormat = intl.DateFormat.d(localeName);

    return SynchronousFuture<CupertinoLocalizations>(
      CupertinoLocalizationTk(
        localeName: localeName,
        decimalFormat: intl.NumberFormat('#,##0.###', 'en'),
        fullYearFormat: intl.DateFormat('y', localeName),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', localeName),
        singleDigitHourFormat: singleDigitHourFormat,
        doubleDigitMinuteFormat: singleDigitMinuteFormat,
        dayFormat: dayFormat,
        singleDigitMinuteFormat: singleDigitMinuteFormat,
        singleDigitSecondFormat: singleDigitSecondFormat,
      ),
    );
  }

  @override
  bool shouldReload(
    covariant LocalizationsDelegate<CupertinoLocalizations> old,
  ) =>
      false;
}

const List<String> _shortWeekdays = <String>[
  'Duş',
  'Siş',
  'Çar',
  'Pen',
  'Ann',
  'Şen',
  'Ýek',
];

const List<String> _shortMonths = <String>[
  'Ýan',
  'Few',
  'Mar',
  'Apr',
  'Maý',
  'Iýn',
  'Iýl',
  'Awg',
  'Sen',
  'Okt',
  'Noý',
  'Dek',
];

const List<String> _months = <String>[
  'Ýanwar',
  'Fewral',
  'Mart',
  'Aprel',
  'Maý',
  'Iýun',
  'Iýul',
  'Awgust',
  'Sentýabr',
  'Oktýabr',
  'Noýabr',
  'Dekabr',
];

class CupertinoLocalizationTk extends GlobalCupertinoLocalizations {
  static const LocalizationsDelegate<CupertinoLocalizations> delegate =
      _TkCupertinoLocalizationsDelegate();

  const CupertinoLocalizationTk({
    String localeName = 'tk',
    required intl.DateFormat fullYearFormat,
    required intl.DateFormat dayFormat,
    required intl.DateFormat mediumDateFormat,
    required intl.DateFormat singleDigitHourFormat,
    required intl.DateFormat singleDigitMinuteFormat,
    required intl.DateFormat doubleDigitMinuteFormat,
    required intl.DateFormat singleDigitSecondFormat,
    required intl.NumberFormat decimalFormat,
  }) : super(
          localeName: localeName,
          fullYearFormat: fullYearFormat,
          dayFormat: dayFormat,
          mediumDateFormat: mediumDateFormat,
          singleDigitHourFormat: singleDigitHourFormat,
          singleDigitMinuteFormat: singleDigitMinuteFormat,
          doubleDigitMinuteFormat: doubleDigitMinuteFormat,
          singleDigitSecondFormat: singleDigitSecondFormat,
          decimalFormat: decimalFormat,
        );

  @override
  List<String> get timerPickerSecondLabels => const <String>['sek.'];

  @override
  String get cutButtonLabel => 'Kesmek';

  @override
  String get copyButtonLabel => 'Kopiýala';

  @override
  String get pasteButtonLabel => 'Giriz';

  @override
  String get selectAllButtonLabel => 'Hemmesini saýla';

  @override
  String get searchTextFieldPlaceholderLabel => 'Gözle';

  @override
  String get modalBarrierDismissLabel => 'Öçür';

  @override
  String get datePickerDateOrderString => 'dmy';

  @override
  String get datePickerDateTimeOrderString => 'date_time_dayPeriod';

  @override
  String? get datePickerHourSemanticsLabelFew => r'$hour sagat';

  @override
  String? get datePickerHourSemanticsLabelMany => r'$hour sagat';

  @override
  String get tabSemanticsLabelRaw => r'$tabCount arasynda $tabIndex-nji jübi';

  @override
  String get timerPickerHourLabelOther => 'sagat';

  @override
  String get timerPickerMinuteLabelOther => 'min.';

  @override
  String get timerPickerSecondLabelOther => 'sеk.';

  @override
  String get datePickerHourSemanticsLabelOther => r'$hour sagat';

  @override
  String get datePickerMinuteSemanticsLabelOther => r'$minute minut';

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder =>
      DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get todayLabel => 'Şu gün';

  @override
  String get alertDialogLabel => 'Üns beriň';

  @override
  List<String> get timerPickerHourLabels => const <String>['sagat', 'sagat'];

  @override
  List<String> get timerPickerMinuteLabels => const <String>['min.'];

  @override
  String get noSpellCheckReplacementsLabel => 'No Replacements Found';

  @override
  String datePickerYear(int yearIndex) => yearIndex.toString();

  @override
  String datePickerMonth(int monthIndex) => _months[monthIndex - 1];

  @override
  String datePickerHour(int hour) => hour.toString();

  @override
  String datePickerHourSemanticsLabel(int hour) => '$hour sagat';

  @override
  String datePickerMinute(int minute) => minute.toString().padLeft(2, '0');

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    return '$minute minut';
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return '${_shortWeekdays[date.weekday - DateTime.monday]} '
        '${_shortMonths[date.month - DateTime.january]} '
        '${date.day.toString().padRight(2)}';
  }

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    assert(tabIndex >= 1);
    assert(tabCount >= 1);
    return '$tabCount arasynda $tabIndex-nji jübi';
  }

  @override
  String timerPickerHour(int hour) => hour.toString();

  @override
  String timerPickerMinute(int minute) => minute.toString();

  @override
  String timerPickerSecond(int second) => second.toString();

  @override
  String timerPickerHourLabel(int hour) => 'sagat';

  @override
  String timerPickerMinuteLabel(int minute) => 'min.';

  @override
  String timerPickerSecondLabel(int second) => 'sek.';
}
