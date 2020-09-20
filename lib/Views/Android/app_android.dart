import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:infinity_ui/infinity_ui.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'package:weatherApp/Constants/translation.dart' as tr;
import 'package:weatherApp/Models/OpenWeather.dart';
import 'package:weatherApp/Providers/WeatherProvider.dart';
import 'package:weatherApp/widgets/custom_circular_refresh_indicator.dart';

class AppAndroid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: tr.localizationDelegates,
        supportedLocales: tr.supportedLocales,
        title: 'Photo Print Layout',
        theme: ThemeData(
          accentColor: Colors.lightBlueAccent,
          accentColorBrightness: Brightness.light,
          backgroundColor: Colors.lightBlueAccent,
          canvasColor: Color(0xFF5DACFA),
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          accentColor: Colors.deepPurpleAccent,
          accentColorBrightness: Brightness.dark,
          backgroundColor: Colors.deepPurple,
          canvasColor: Colors.deepPurple[800],
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeAndroid());
  }
}

class SliverPersistentPadding implements SliverPersistentHeaderDelegate {
  final double maxExtent;
  final double minExtent;
  final Color beginColor;
  final Color endColor;

  SliverPersistentPadding(
      {this.maxExtent, this.minExtent, this.beginColor, this.endColor});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [beginColor, endColor])),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration =>
      null;

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  TickerProvider get vsync => null;
}

class ExampleContainer extends StatelessWidget {
  final text;
  final color;
  const ExampleContainer({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
          child: Text(
        text,
        overflow: TextOverflow.fade,
      )),
      height: 250,
    );
  }
}

class HomeAndroid extends StatelessWidget {
  HomeAndroid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetList = [
      ExampleContainer(
        color: Theme.of(context).canvasColor,
        text: "Alabama",
      ),
      ExampleContainer(
        color: Theme.of(context).canvasColor,
        text: "Obama Weather",
      ),
      ExampleContainer(
        color: Theme.of(context).canvasColor,
        text: "Obama Weather",
      ),
      ExampleContainer(
        color: Theme.of(context).canvasColor,
        text: "Obama Weather",
      ),
    ];
    return Scaffold(
        drawer: Drawer(
          child: Material(
            color: Theme.of(context).backgroundColor,
            child: ListView(
              padding: EdgeInsets.only(top: InfinityUi.statusBarHeight + 100),
              children: [
                ListTile(
                  title: Text(
                    "Weather Box",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.white.withOpacity(0.1),
                ),
                SizedBox(height: 10),
                // Current location section
                ListTile(
                  dense: true,
                  title: Text(
                    tr.Translations.of(context).currentLocation,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: Text(
                    tr.Translations.of(context).currentLocationDescription,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                Consumer<WeatherProvider>(
                  builder: (context, provider, child) => ListTile(
                      dense: true,
                      onTap: () {},
                      title: Text(
                        provider.available
                            ? "${provider?.placemarks?.first?.subAdministrativeArea}"
                            : "404",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        provider.available
                            ? "${provider?.placemarks?.first?.isoCountryCode} | ${provider?.placemarks?.first?.subAdministrativeArea} | ${provider?.placemarks?.first?.postalCode}"
                            : "404",
                        style: Theme.of(context).textTheme.caption,
                      )),
                ),
                Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.white.withOpacity(0.1),
                ),
                SizedBox(height: 10),
                // Saved places section
                ListTile(
                  dense: true,
                  title: Text(
                    tr.Translations.of(context).savedLocations,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: Text(
                    tr.Translations.of(context).savedLocationsDescription,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: InfinityUi.navigationBarHeight),
          child: FloatingActionButton(
            child: Icon(MdiIcons.cityVariantOutline),
            onPressed: () {
              Provider.of<WeatherProvider>(context, listen: false)
                  .updateOpenWeather(
                      lat: 50.30,
                      lon: 18.7,
                      context: null,
                      locale: Localizations.localeOf(context));
            },
          ),
        ),
        body: RefreshIndicator(
          displacement: 75,
          strokeWidth: 2,
          backgroundColor: Theme.of(context).accentColor,
          color: Colors.white,
          onRefresh: () {
            return Future.delayed(Duration(milliseconds: 1000));
          },
          child: Stack(children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPersistentPadding(
                      maxExtent: InfinityUi.statusBarHeight,
                      minExtent: InfinityUi.statusBarHeight,
                      beginColor: Theme.of(context).canvasColor,
                      endColor: Theme.of(context).canvasColor),
                ),
                SliverAppBar(
                  title: Consumer<WeatherProvider>(
                    builder: (context, provider, child) => Text(
                      provider.available
                          ? "Lat ${provider.position.latitude.toStringAsFixed(2)}, lon: ${provider.position.longitude.toStringAsFixed(2)}, alt: ${provider.position.altitude.toStringAsFixed(2)}"
                          : "Yo nigga nowhere",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  backgroundColor: Theme.of(context).canvasColor,
                  floating: false,
                  pinned: true,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: double.infinity,
                      width: double.infinity,
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         colors: [Colors.blue[300], Colors.blue[200]],
                      //         begin: Alignment.bottomCenter,
                      //         end: Alignment.topCenter)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Consumer<WeatherProvider>(
                          builder: (context, provider, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(provider.available
                                  ? "${(provider.openWeatherResponse.current.temp - 273.15).toStringAsFixed(2)} °C"
                                  : "Waiting"),
                              Text(provider.available
                                  ? "Feels like ${(provider.openWeatherResponse.current.feelsLike - 273.15).toStringAsFixed(2)} °C"
                                  : "Waiting"),
                              Text(provider.available
                                  ? "${provider.openWeatherResponse.current.weather[0].main}"
                                  : "Waiting"),
                              Text(provider.available
                                  ? "${provider.openWeatherResponse.current.weather[0].description}"
                                  : "Waiting"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    collapseMode: CollapseMode.parallax,
                    centerTitle: false,
                  ),
                  expandedHeight: MediaQuery.of(context).size.height / 3,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverPersistentPadding(
                      maxExtent: 50,
                      minExtent: 50,
                      beginColor:
                          Theme.of(context).canvasColor.withOpacity(0.1),
                      endColor: Theme.of(context).canvasColor),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => widgetList[index],
                      childCount: widgetList.length),
                ),
                //Hide bottom overlay
              ],
            ),
            // TODO it should be handled in sliver list
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: InfinityUi.statusLSBarHeight,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).canvasColor.withOpacity(0),
                  Theme.of(context).canvasColor.withOpacity(0.8),
                  Theme.of(context).canvasColor.withOpacity(1)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
            ),
          ]),
        ));
  }
}

// SLIVER FOOTER
