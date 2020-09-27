// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenWeather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenWeatherOneCall _$OpenWeatherOneCallFromJson(Map<String, dynamic> json) {
  return OpenWeatherOneCall(
    lat: (json['lat'] as num)?.toDouble(),
    lon: (json['lon'] as num)?.toDouble(),
    timezone: json['timezone'] as String,
    timezoneOffset: json['timezone_offset'] as int,
    current: json['current'] == null
        ? null
        : OpenWeatherOneCallCurrent.fromJson(
            json['current'] as Map<String, dynamic>),
    minutely: (json['minutely'] as List)
        ?.map((e) => e == null
            ? null
            : OneCallMinutely.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    hourly: (json['hourly'] as List)
        ?.map((e) => e == null
            ? null
            : OneCallHourly.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    daily: (json['daily'] as List)
        ?.map((e) =>
            e == null ? null : OneCallDaily.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OpenWeatherOneCallToJson(OpenWeatherOneCall instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'timezone_offset': instance.timezoneOffset,
      'current': instance.current?.toJson(),
      'minutely': instance.minutely?.map((e) => e?.toJson())?.toList(),
      'hourly': instance.hourly?.map((e) => e?.toJson())?.toList(),
      'daily': instance.daily?.map((e) => e?.toJson())?.toList(),
    };

OpenWeatherOneCallCurrent _$OpenWeatherOneCallCurrentFromJson(
    Map<String, dynamic> json) {
  return OpenWeatherOneCallCurrent(
    dt: json['dt'] as int,
    sunrise: json['sunrise'] as int,
    sunset: json['sunset'] as int,
    temp: (json['temp'] as num)?.toDouble(),
    feelsLike: (json['feels_like'] as num)?.toDouble(),
    pressure: (json['pressure'] as num)?.toDouble(),
    humidity: json['humidity'] as int,
    dewPoint: (json['dew_point'] as num)?.toDouble(),
    uvi: (json['uvi'] as num)?.toDouble(),
    clouds: json['clouds'] as int,
    visibility: json['visibility'] as int,
    windSpeed: (json['wind_speed'] as num)?.toDouble(),
    windDeg: json['wind_deg'] as int,
    windGust: (json['wind_gust'] as num)?.toDouble(),
    rain: (json['rain'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as num)?.toDouble()),
    ),
    snow: (json['snow'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as num)?.toDouble()),
    ),
    weather: (json['weather'] as List)
        ?.map((e) => e == null
            ? null
            : OneCallWeather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OpenWeatherOneCallCurrentToJson(
        OpenWeatherOneCallCurrent instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dewPoint,
      'uvi': instance.uvi,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'wind_speed': instance.windSpeed,
      'wind_deg': instance.windDeg,
      'wind_gust': instance.windGust,
      'rain': instance.rain,
      'snow': instance.snow,
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
    };

OneCallWeather _$OneCallWeatherFromJson(Map<String, dynamic> json) {
  return OneCallWeather(
    id: json['id'] as int,
    main: json['main'] as String,
    description: json['description'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$OneCallWeatherToJson(OneCallWeather instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

OneCallMinutely _$OneCallMinutelyFromJson(Map<String, dynamic> json) {
  return OneCallMinutely(
    dt: json['dt'] as int,
    precipitation: (json['precipitation'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OneCallMinutelyToJson(OneCallMinutely instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'precipitation': instance.precipitation,
    };

OneCallHourly _$OneCallHourlyFromJson(Map<String, dynamic> json) {
  return OneCallHourly(
    dt: json['dt'] as int,
    temp: (json['temp'] as num)?.toDouble(),
    feelsLike: (json['feels_like'] as num)?.toDouble(),
    pressure: (json['pressure'] as num)?.toDouble(),
    humidity: json['humidity'] as int,
    dewPoint: (json['dew_point'] as num)?.toDouble(),
    clouds: json['clouds'] as int,
    visibility: json['visibility'] as int,
    windSpeed: (json['wind_speed'] as num)?.toDouble(),
    windGust: (json['wind_gust'] as num)?.toDouble(),
    windDeg: json['wind_deg'] as int,
    rain: (json['rain'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as num)?.toDouble()),
    ),
    snow: (json['snow'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as num)?.toDouble()),
    ),
    weather: (json['weather'] as List)
        ?.map((e) => e == null
            ? null
            : OneCallWeather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pop: (json['pop'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OneCallHourlyToJson(OneCallHourly instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dewPoint,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'wind_speed': instance.windSpeed,
      'wind_gust': instance.windGust,
      'wind_deg': instance.windDeg,
      'rain': instance.rain,
      'snow': instance.snow,
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
      'pop': instance.pop,
    };

OneCallDaily _$OneCallDailyFromJson(Map<String, dynamic> json) {
  return OneCallDaily(
    dt: json['dt'] as int,
    sunrise: json['sunrise'] as int,
    sunset: json['sunset'] as int,
    temp: json['temp'] == null
        ? null
        : OneCallTemp.fromJson(json['temp'] as Map<String, dynamic>),
    feelsLike: json['feels_like'] == null
        ? null
        : OneCallFeelsLike.fromJson(json['feels_like'] as Map<String, dynamic>),
    pressure: (json['pressure'] as num)?.toDouble(),
    humidity: json['humidity'] as int,
    dewPoint: (json['dew_point'] as num)?.toDouble(),
    windSpeed: (json['wind_speed'] as num)?.toDouble(),
    windDeg: json['wind_deg'] as int,
    weather: (json['weather'] as List)
        ?.map((e) => e == null
            ? null
            : OneCallWeather.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    clouds: json['clouds'] as int,
    pop: (json['pop'] as num)?.toDouble(),
    uvi: (json['uvi'] as num)?.toDouble(),
    windGust: (json['wind_gust'] as num)?.toDouble(),
    visibility: json['visibility'] as int,
    rain: (json['rain'] as num)?.toDouble(),
    snow: (json['snow'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OneCallDailyToJson(OneCallDaily instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'temp': instance.temp?.toJson(),
      'feels_like': instance.feelsLike?.toJson(),
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dew_point': instance.dewPoint,
      'wind_speed': instance.windSpeed,
      'wind_gust': instance.windGust,
      'wind_deg': instance.windDeg,
      'weather': instance.weather?.map((e) => e?.toJson())?.toList(),
      'clouds': instance.clouds,
      'pop': instance.pop,
      'uvi': instance.uvi,
      'visibility': instance.visibility,
      'rain': instance.rain,
      'snow': instance.snow,
    };

OneCallTemp _$OneCallTempFromJson(Map<String, dynamic> json) {
  return OneCallTemp(
    day: (json['day'] as num)?.toDouble(),
    min: (json['min'] as num)?.toDouble(),
    max: (json['max'] as num)?.toDouble(),
    night: (json['night'] as num)?.toDouble(),
    eve: (json['eve'] as num)?.toDouble(),
    morn: (json['morn'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OneCallTempToJson(OneCallTemp instance) =>
    <String, dynamic>{
      'day': instance.day,
      'min': instance.min,
      'max': instance.max,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };

OneCallFeelsLike _$OneCallFeelsLikeFromJson(Map<String, dynamic> json) {
  return OneCallFeelsLike(
    day: (json['day'] as num)?.toDouble(),
    night: (json['night'] as num)?.toDouble(),
    eve: (json['eve'] as num)?.toDouble(),
    morn: (json['morn'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OneCallFeelsLikeToJson(OneCallFeelsLike instance) =>
    <String, dynamic>{
      'day': instance.day,
      'night': instance.night,
      'eve': instance.eve,
      'morn': instance.morn,
    };
