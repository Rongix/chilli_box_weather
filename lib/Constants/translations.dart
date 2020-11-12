import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Iterable<LocalizationsDelegate<dynamic>> localizationDelegates = [
  TranslationsDelegate(),
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Iterable<Locale> supportedLocales = [
  const Locale('en', 'US'), // English
  const Locale('pl', 'PL'), // Polish
];

// It is used in Localizations Delegates to rebuild UI when locale changes
class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => supportedLocales.contains(locale);

  @override
  Future<Translations> load(Locale locale) =>
      Translations.fromFile(locale: locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<Translations> old) => false;
}

// Strings used in UI
class Translations {
  static Locale locale;

  static Map<String, String> _localizedStrings;

  static Future<Translations> fromFile({@required Locale locale}) async {
    var content =
        await rootBundle.loadString('Translation/${locale.languageCode}.json');
    Map<String, dynamic> json = jsonDecode(content);
    var translation =
        json.map<String, String>((key, value) => MapEntry(key, value));
    return Translations(locale: locale, localizedStrings: translation);
  }

  Translations({@required locale, @required localizedStrings}) {
    _localizedStrings = localizedStrings;
  }

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  // If Locale is not supported, then English translation will be returned
  static String _resolveTranslation(String key) {
    return _localizedStrings[key] ?? "Err: Tr404 !$key";
  }

  static String get test => _resolveTranslation("test");
  static String get currentLocation => _resolveTranslation("current_location");
  static String get currentLocationDescription =>
      _resolveTranslation("current_location_description");
  static String get savedLocations => _resolveTranslation("saved_locations");
  static String get savedLocationsDescription =>
      _resolveTranslation("saved_locations_description");
  static String get feelsLike => _resolveTranslation("feels_like");
  static String get overview => _resolveTranslation("overview");
  static String get now => _resolveTranslation("now");
  static String get geolocation => _resolveTranslation("geolocation");
  static String get atmospheric => _resolveTranslation("atmospheric");
  static String get soon => _resolveTranslation("soon");
}
