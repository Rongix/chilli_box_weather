import 'package:flutter/foundation.dart';
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
      SynchronousFuture<Translations>(Translations(locale: locale));

  @override
  bool shouldReload(covariant LocalizationsDelegate<Translations> old) => false;
}

// Strings used in UI
class Translations {
  final Locale locale;

  Translations({@required this.locale});

  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations);
  }

  static Map<String, Map<String, String>> _localizedStrings = {
    // English translation is default one
    'en': {
      'test': 'This is a test text',
    },
    // Polish translation
    'pl': {
      'test': 'To jest tekst przykładowy',
    },
  };

  // If Locale is not supported, then English translation will be returned
  String _resolveTranslation(String key) {
    return _localizedStrings[locale.languageCode][key] ??
        _localizedStrings["en"][key];
  }

  String get test => _resolveTranslation("test");
}
