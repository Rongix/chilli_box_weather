import 'package:flutter/widgets.dart';

// Info:
// User can supply multiple weather providers (api keys that provide weather), they are stored,
// and piped to widgets from here.

// Handling updates:
// Default weather provider for app is Open Weather, users can refresh weather once every 30 mins (weather data in server
// gets updated once every 15-30 mins)

// Fetch data only if widget asks for it
// Widgets can be set to use weather provider and data gets fetched only if widget requires it. Every widget can have
// different weather provider source.
class WeatherProvider extends ChangeNotifier {}
