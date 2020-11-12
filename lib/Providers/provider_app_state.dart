import 'package:flutter/widgets.dart';
import 'package:weatherApp/Constants/translations.dart';

class AppStateProvider extends ChangeNotifier {
  // ["Overview", "Now", "Geolocation", "Atmospheric", "Soon"];
  var sectionTitles = [
    Translations.overview,
    Translations.now,
    Translations.atmospheric,
    Translations.geolocation,
    Translations.soon
  ];
}
