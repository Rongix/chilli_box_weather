import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:weatherApp/Constants/ApiKeys.dart' as apiKeys;

enum OpenWeatherApiForecastType {
  weather,
  forecast,
  oneCall,
}

class OpenWeatherApi {
  // EXAMPLES:
  // api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
  // api.openweathermap.org/data/2.5/weather?id={city id}&appid={your api key}
  // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
  // api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}&appid={your api key}

  // Can make request for current weather or forecast: based on city name, city name & country code, latitude & longitude
  // ignore: missing_return
  static Future<Map<String, dynamic>> getWeather(
      {OpenWeatherApiForecastType type,
      String cityName,
      String countryCode,
      double lat,
      double lon}) async {
    var uri = buildRequestBody(
        cityName: cityName, countryCode: countryCode, lat: lat, lon: lon);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      return data;
    } else {
      //Todo handle fail
      print("FAILED");
    }
  }

  // It is used in generating request string
  // Preferable way to get weather data is to provider lat & lon
  static String buildRequestBody(
      {OpenWeatherApiForecastType weatherType,
      String cityName,
      String countryCode,
      double lat,
      double lon}) {
    var baseString = "http://api.openweathermap.org/data/2.5/";
    var apiString = "&appid=${apiKeys.openWeatherAPI}";
    var weatherString;
    var locationString;

    if (weatherType != null) {
      switch (weatherType) {
        case OpenWeatherApiForecastType.weather:
          weatherString = "weather?";
          break;
        case OpenWeatherApiForecastType.forecast:
          weatherString = "forecast?";
          break;
        case OpenWeatherApiForecastType.oneCall:
          weatherString = "onecall?";
          break;
      }
    } else {
      weatherString = "weather?";
    }

    if (lat != null && lon != null) {
      locationString = "lat=$lat&lon=$lon";
    } else {
      locationString = "q=$cityName";
    }

    return baseString + weatherString + locationString + apiString;
  }
}

class WeatherProvider extends ChangeNotifier {}
