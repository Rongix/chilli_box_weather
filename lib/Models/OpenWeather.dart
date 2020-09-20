import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:weatherApp/Constants/api_keys.dart' as apiKeys;

// Generate code with: flutter pub run build_runner build
part 'OpenWeather.g.dart';

enum OpenWeatherApiWeatherType {
  weather,
  forecast,
  onecall,
}

// Default open weather locale is "en"
var openWeatherApiSupportedLocale = [
  "ar",
  "bg",
  "ca",
  "cz",
  "de",
  "el",
  "en",
  "fa",
  "fi",
  "fr",
  "gl",
  "hr",
  "hu",
  "it",
  "ja",
  "kr",
  "la",
  "lt",
  "mk",
  "nl",
  "pl",
  "pt",
  "ro",
  "ru",
  "se",
  "sk",
  "sl",
  "es",
  "tr",
  "ua",
  "vi",
  "zh_cn",
  "zh_tw"
];

class OpenWeatherApi {
  static const baseString = "https://api.openweathermap.org/data/2.5/";

  // EXAMPLES:
  // api.openweathermap.org/data/2.5/weather?q={city name}&appid={your api key}
  // api.openweathermap.org/data/2.5/weather?id={city id}&appid={your api key}
  // api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={your api key}
  // api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}&appid={your api key}

  static Future<OpenWeatherOneCall> oneCall(
      {@required double lat,
      @required double lon,
      @required Locale locale}) async {
    Locale supportedLocale;
    print(locale);
    if (openWeatherApiSupportedLocale.contains(locale.languageCode)) {
      print('setting ${locale.languageCode} locale in api');
      supportedLocale = locale;
    } else {
      print('setting en locale in api');
      supportedLocale = Locale(
        'en',
      );
    }
    var uri = baseString +
        "onecall?lat=$lat&lon=$lon&appid=${apiKeys.openWeatherAPI}&lang=${supportedLocale.languageCode}";
    var response = await http.get(uri);
    switch (response.statusCode) {
      case 200:
        {
          var data = json.decode(response.body);
          var a = OpenWeatherOneCall.fromJson(data);
          var time = a.current.dt;
          var timenormal2 = DateTime.fromMillisecondsSinceEpoch(time * 1000);
          print("milliseconds time: $timenormal2");
          return a;
        }
      default:
        {
          print('fail');
          return null;
        }
    }
  }
}

@JsonSerializable(explicitToJson: true)
class OpenWeatherOneCall {
  final double lat;
  final double lon;
  final String timezone;
  @JsonKey(name: 'timezone_offset')
  final int timezoneOffset;
  final OpenWeatherOneCallCurrent current;
  final List<OneCallMinutely> minutely;
  final List<OneCallHourly> hourly;
  final List<OneCallDaily> daily;

  OpenWeatherOneCall(
      {this.lat,
      this.lon,
      this.timezone,
      this.timezoneOffset,
      this.current,
      this.minutely,
      this.hourly,
      this.daily});

  factory OpenWeatherOneCall.fromJson(Map<String, dynamic> data) =>
      _$OpenWeatherOneCallFromJson(data);

  Map<String, dynamic> toJson() => _$OpenWeatherOneCallToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OpenWeatherOneCallCurrent {
  // Unix, UTC
  final int dt;
  final int sunrise;
  final int sunset;
  // Kelvin
  final double temp;
  // Kelvin - This accounts for the human perception of weather
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  // Atmospheric pressure on the sea level, hPa
  final double pressure;
  // Humidity, %
  final int humidity;
  // Atmospheric temperature (varying according to pressure and humidity)
  // below which water droplets begin to condense and dew can form, Kelvin
  @JsonKey(name: 'drew_point')
  final double drewPoint;
  // Midday UV index
  final double uvi;
  // Cloudiness, %
  final int clouds;
  // Average visibility, metres
  final int visibility;
  // Wind speed. Units – default: metre/sec,
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  // Wind direction, degrees (meteorological)
  @JsonKey(name: 'wind_deg')
  final int windDeg;
  // Wind gust. Wind speed. Units – default: metre/sec
  @JsonKey(name: 'wind_gust')
  final double windGust;
  // Precipitation volume, mm
  final double rain;
  // Snow volume, mm
  final Map<String, double> snow;
  final List<OneCallWeather> weather;

  OpenWeatherOneCallCurrent(
      {this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.drewPoint,
      this.uvi,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windDeg,
      this.windGust,
      this.rain,
      this.snow,
      this.weather});

  factory OpenWeatherOneCallCurrent.fromJson(Map<String, dynamic> data) =>
      _$OpenWeatherOneCallCurrentFromJson(data);

  Map<String, dynamic> toJson() => _$OpenWeatherOneCallCurrentToJson(this);
}

@JsonSerializable()
class OneCallWeather {
  final int id;
  final String main;
  final String description;
  final String icon;

  OneCallWeather({this.id, this.main, this.description, this.icon});

  factory OneCallWeather.fromJson(Map<String, dynamic> data) =>
      _$OneCallWeatherFromJson(data);

  Map<String, dynamic> toJson() => _$OneCallWeatherToJson(this);
}

@JsonSerializable()
class OneCallMinutely {
  final int dt;
  final int precipitation;

  OneCallMinutely({this.dt, this.precipitation});

  factory OneCallMinutely.fromJson(Map<String, dynamic> data) =>
      _$OneCallMinutelyFromJson(data);

  Map<String, dynamic> toJson() => _$OneCallMinutelyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OneCallHourly {
  // Time of historical data, Unix, UTC
  final int dt;
  // Temperature. Units – default: kelvin
  final double temp;
  // Temperature. This accounts for the human perception of weather. Units – default: kelvin
  @JsonKey(name: 'feels_like')
  final double feelsLike;
  // Atmospheric pressure on the sea level, hPa
  final double pressure;
  // Humidity, %
  final int humidity;
  // Atmospheric temperature (varying according to pressure and humidity)
  // below which water droplets begin to condense and dew can form.
  // Units – default: kelvin
  @JsonKey(name: 'dew_point')
  final double dewPoint;
  // Cloudiness, %
  final int clouds;
  // Average visibility, metres
  final int visibility;
  // Wind speed. Wind speed. Units – default: metre/sec
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  // Wind gust. Units – default: metre/sec
  @JsonKey(name: 'wind_gust')
  final double windGust;
  // Wind direction, degrees (meteorological)
  @JsonKey(name: 'wind_deg')
  final int windDeg;
  // Precipitation volume, mm
  final Map<String, double> rain;
  // Snow volume, mm
  final Map<String, double> snow;
  final List<OneCallWeather> weather;
  final double pop;

  OneCallHourly(
      {this.dt,
      this.temp,
      this.feelsLike,
      this.pressure,
      this.humidity,
      this.dewPoint,
      this.clouds,
      this.visibility,
      this.windSpeed,
      this.windGust,
      this.windDeg,
      this.rain,
      this.snow,
      this.weather,
      this.pop});

  factory OneCallHourly.fromJson(Map<String, dynamic> data) =>
      _$OneCallHourlyFromJson(data);

  Map<String, dynamic> toJson() => _$OneCallHourlyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OneCallDaily {
  // Time of the forecasted data, Unix, UTC
  final int dt;
  final int sunrise;
  final int sunset;
  // Units – default: kelvin
  final OneCallTemp temp;
  // This accounts for the human perception of weather. Units – default: kelvin
  @JsonKey(name: 'feels_like')
  final OneCallFeelsLike feelsLike;
  // Atmospheric pressure on the sea level, hPa
  final double pressure;
  // Humidity, %
  final int humidity;
  // Atmospheric temperature (varying according to pressure and humidity)
  // below which water droplets begin to condense and dew can form.
  // Units – default: kelvin
  @JsonKey(name: 'dew_point')
  final double dewPoint;
  //Wind speed. Units – default: metre/sec
  @JsonKey(name: 'wind_speed')
  final double windSpeed;
  // Wind gust. Units – default: metre/sec
  @JsonKey(name: 'wind_gust')
  final double windGust;
  // Wind direction, degrees (meteorological)
  @JsonKey(name: 'wind_deg')
  final int windDeg;
  final List<OneCallWeather> weather;
  // Cloudiness, %
  final int clouds;
  // Probability of precipitation
  final double pop;
  // Midday UV index
  final double uvi;
  // Average visibility, metres
  final int visibility;
  // double rain and double snow in daily are different than other forecasts
  // Precipitation volume, mm
  final double rain;
  // Snow volume, mm
  final double snow;

  OneCallDaily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
    this.windGust,
    this.visibility,
    this.rain,
    this.snow,
  });

  factory OneCallDaily.fromJson(Map<String, dynamic> data) =>
      _$OneCallDailyFromJson(data);

  Map<String, dynamic> toJson() => _$OneCallDailyToJson(this);
}

@JsonSerializable()
class OneCallTemp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  OneCallTemp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  factory OneCallTemp.fromJson(Map<String, dynamic> data) =>
      _$OneCallTempFromJson(data);

  Map<String, dynamic> toJson() => _$OneCallTempToJson(this);
}

@JsonSerializable()
class OneCallFeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  OneCallFeelsLike({this.day, this.night, this.eve, this.morn});

  factory OneCallFeelsLike.fromJson(Map<String, dynamic> data) =>
      _$OneCallFeelsLikeFromJson(data);

  Map<String, dynamic> toJson() => _$OneCallFeelsLikeToJson(this);
}
