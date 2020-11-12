import 'package:flutter/widgets.dart';

class CompactLocationWeather {
  final String locationName;
  final double temp;
  final double feelsLikeTemp;
  final String description;
  final double precipation;

  CompactLocationWeather(
      {@required this.locationName,
      @required this.temp,
      @required this.feelsLikeTemp,
      this.description,
      @required this.precipation});
}
