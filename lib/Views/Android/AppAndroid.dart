import 'package:flutter/material.dart';

import 'package:weatherApp/Constants/Translation.dart' as tr;
import 'package:weatherApp/Providers/WeatherProvider.dart';

class AppAndroid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: tr.localizationDelegates,
        supportedLocales: tr.supportedLocales,
        title: 'Photo Print Layout',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeAndroid());
  }
}

class HomeAndroid extends StatelessWidget {
  const HomeAndroid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              OpenWeatherApi.getWeather(
                  cityName: "Zabrze",
                  countryCode: "pl",
                  lat: null,
                  lon: null,
                  type: OpenWeatherApiForecastType.oneCall);
            },
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('asdasd'),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(tr.Translations.of(context).test),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
