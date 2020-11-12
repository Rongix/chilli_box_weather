import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weatherApp/Models/open_weather.dart';

import 'package:geolocator/geolocator.dart';

// Info:
// User can supply multiple weather providers (api keys that provide weather), they are stored,
// and piped to widgets from here.

// Handling updates:
// Default weather provider for app is Open Weather, users can refresh weather once every 30 mins (weather data in server
// gets updated once every 15-30 mins)

// Fetch data only if widget asks for it
// Widgets can be set to use weather provider and data gets fetched only if widget requires it. Every widget can have
// different weather provider source.
class WeatherProvider extends ChangeNotifier {
  OpenWeatherOneCall _openWeatherResponse;
  Position _position;
  bool _available = false;
  List<Placemark> _placemarks;
  bool _useGeolocation = true;

  Future<void> updateOpenWeather(
      {@required BuildContext context,
      @required double lat,
      @required double lon,
      @required Locale locale}) async {
    _position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    _openWeatherResponse = await OpenWeatherApi.oneCall(
        lat: _position.latitude, lon: _position.longitude, locale: locale);
    if (_position != null && _openWeatherResponse != null) {
      _available = true;
    }
    _placemarks =
        await placemarkFromCoordinates(_position.latitude, _position.longitude);

    notifyListeners();
  }

  set useGeolocation(bool state) {
    _useGeolocation = state;
    notifyListeners();
  }

  OpenWeatherOneCall get openWeatherResponse => _openWeatherResponse;
  Position get position => _position;
  bool get available => _available;
  List<Placemark> get placemarks => _placemarks;
  bool get useGeolocation => _useGeolocation;
}
