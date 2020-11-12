import 'package:flutter/widgets.dart';

class WeatherDataContainer {
  // Main information displayed by widget
  final dynamic data;
  // Visibility changed by user
  final bool display;
  // Additional info
  final String description;
  // Leading icon
  final Icon leading;

  WeatherDataContainer({
    @required this.data,
    this.display,
    this.description,
    this.leading,
  });
}
