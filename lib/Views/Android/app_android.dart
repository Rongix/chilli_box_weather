import 'dart:ui';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinity_ui/infinity_ui.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:weatherApp/Constants/translation.dart' as tr;
import 'package:weatherApp/Models/OpenWeather.dart';
import 'package:weatherApp/Providers/WeatherProvider.dart';
import 'package:weatherApp/Utils/utils.dart';

import "dart:math";

class AppAndroid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: tr.localizationDelegates,
        supportedLocales: tr.supportedLocales,
        title: 'Photo Print Layout',
        theme: ThemeData(
          brightness: Brightness.light,
          accentColorBrightness: Brightness.light,
          accentColor: Colors.lightBlue[300],
          backgroundColor: Color(0xFF5DACFA),
          canvasColor: Color(0xFF5DACFA),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   accentColor: Colors.deepPurpleAccent,
        //   accentColorBrightness: Brightness.dark,
        //   backgroundColor: Colors.deepPurple,
        //   canvasColor: Colors.deepPurple[800],
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColorBrightness: Brightness.dark,
          accentColor: Colors.grey[800],
          backgroundColor: Colors.grey[900],
          canvasColor: Colors.black,
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
        style: TextStyle(color: Colors.white),
      )),
      height: 150,
    );
  }
}

class HomeAndroid extends StatelessWidget {
  HomeAndroid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetList = [
      TodayOverviewWidget(),
    ];

    var locationStyle = Theme.of(context).textTheme.headline6.copyWith(
        color: calculateContrastColor(
            Theme.of(context).canvasColor, Colors.black, Colors.white));
    var descriptionStyle = Theme.of(context).textTheme.caption.copyWith(
        color: calculateContrastColor(Theme.of(context).canvasColor,
            Colors.black.withOpacity(0.8), Colors.white.withOpacity(0.8)));
    return Scaffold(
        drawer: DrawerAndroid(),
        backgroundColor: Theme.of(context).canvasColor,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom: InfinityUi.navigationBarHeight + 16, right: 0),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
            child: Icon(
              MdiIcons.cityVariantOutline,
              color: calculateContrastColor(
                  Theme.of(context).accentColor, Colors.black, Colors.white),
            ),
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
          displacement: 30,
          strokeWidth: 3,
          backgroundColor: Theme.of(context).accentColor,
          color: Colors.white,
          onRefresh: () {
            return Provider.of<WeatherProvider>(context, listen: false)
                .updateOpenWeather(
                    context: context,
                    lat: null,
                    lon: null,
                    locale: Localizations.localeOf(context));
          },
          child: Stack(children: [
            CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
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
                    builder: (context, provider, child) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            //Converting icon to text
                            Text(
                              String.fromCharCode(MdiIcons.mapCheck.codePoint),
                              style: TextStyle(
                                  fontFamily: MdiIcons.mapCheck.fontFamily,
                                  package: MdiIcons.mapCheck.fontPackage),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                provider.available
                                    ? "${provider?.placemarks?.first?.subAdministrativeArea}"
                                    : "404",
                                style: locationStyle),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            provider.available
                                ? "${provider?.placemarks?.first?.isoCountryCode} | ${provider?.placemarks?.first?.administrativeArea} | ${provider?.placemarks?.first?.postalCode}"
                                : "404",
                            style: descriptionStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Theme.of(context).canvasColor,
                  floating: false,
                  pinned: true,
                ),
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: SliverPersistentPadding(
                //       maxExtent: 20,
                //       minExtent: 20,
                //       beginColor:
                //           Theme.of(context).canvasColor.withOpacity(0.1),
                //       endColor: Theme.of(context).canvasColor),
                // ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => widgetList[index],
                      childCount: widgetList.length),
                ),
                // WeatherGrid(),

                //Hide bottom overlay
              ],
            ),
            // TODO it should be handled in sliver list
          ]),
        ));
  }
}

// DRAWER with locations
class DrawerAndroid extends StatelessWidget {
  const DrawerAndroid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drawerBackgroundColor = Theme.of(context).backgroundColor;
    var headingStyle = Theme.of(context).textTheme.headline5.copyWith(
        color: calculateContrastColor(
            drawerBackgroundColor, Colors.black, Colors.white));
    var locationStyle = Theme.of(context).textTheme.headline6.copyWith(
        color: calculateContrastColor(
            drawerBackgroundColor, Colors.black, Colors.white));
    var descriptionStyle = Theme.of(context).textTheme.caption.copyWith(
        color: calculateContrastColor(drawerBackgroundColor,
            Colors.black.withOpacity(0.8), Colors.white.withOpacity(0.8)));
    var iconColor = calculateContrastColor(
        drawerBackgroundColor, Colors.black, Colors.white);
    var dividerColor = calculateContrastColor(drawerBackgroundColor,
        Colors.black.withOpacity(0.3), Colors.white.withOpacity(0.3));
    var bigHeadingStyle = Theme.of(context)
        .textTheme
        .headline5
        .copyWith(
            color: calculateContrastColor(
                drawerBackgroundColor, Colors.black, Colors.white))
        .copyWith(fontFamily: GoogleFonts.getFont('Rubik Mono One').fontFamily);
    var dancingStyle = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(
            color: calculateContrastColor(drawerBackgroundColor,
                Colors.black.withOpacity(0.8), Colors.white.withOpacity(0.8)))
        .copyWith(fontFamily: GoogleFonts.getFont('Dancing Script').fontFamily);

    return Drawer(
      child: Material(
        color: drawerBackgroundColor,
        child: ListView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          padding: EdgeInsets.only(top: InfinityUi.statusBarHeight + 20),
          children: [
            ListTile(
              // cool fonts: Rubik Mono One   Slackey  Spirax   Kumar One
              // title: Text("Weather Box",
              //     style: headingStyle.copyWith(
              //         fontFamily:
              //             GoogleFonts.getFont('Press Start 2P').fontFamily)),
              title: RichText(
                  text: TextSpan(style: bigHeadingStyle, children: [
                TextSpan(text: "Weather "),
                TextSpan(
                  text: "Chilli Box",
                  style: bigHeadingStyle.copyWith(
                    color: Colors.yellow[400],
                  ),
                ),
                TextSpan(
                    text:
                        "\n\"If you are a chilli pepper, every day is hella hot\"",
                    style: descriptionStyle),
              ])),
              trailing: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: IconButton(
                  icon: Icon(
                    MdiIcons.cogs,
                    color: iconColor,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineThickness: 2,
              dashLength: 2,
              dashColor: dividerColor,
            ),
            SizedBox(height: 5),
            // Current location section
            ListTile(
              dense: true,
              title: Text(
                tr.Translations.of(context).currentLocation,
                style: headingStyle,
              ),
              subtitle: Text(
                tr.Translations.of(context).currentLocationDescription,
                style: descriptionStyle,
              ),
            ),
            // Location Tile
            Consumer<WeatherProvider>(
              builder: (context, provider, child) => ListTile(
                  dense: true,
                  onTap: () {},
                  title: Text(
                    provider.available
                        ? "${provider?.placemarks?.first?.subAdministrativeArea}"
                        : "404",
                    style: locationStyle,
                  ),
                  subtitle: Text(
                    provider.available
                        ? "${provider?.placemarks?.first?.isoCountryCode} | ${provider?.placemarks?.first?.administrativeArea} | ${provider?.placemarks?.first?.postalCode}"
                        : "404",
                    style: descriptionStyle,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      provider.useGeolocation = !provider.useGeolocation;
                    },
                    icon: Icon(
                      provider.useGeolocation
                          ? MdiIcons.mapMarker
                          : MdiIcons.mapMarkerOff,
                      color: iconColor.withOpacity(0.5),
                    ),
                  ),
                  leading: Checkbox(
                    activeColor: Theme.of(context).accentColor,
                    checkColor: iconColor,
                    onChanged: (bool value) {},
                    value: true,
                  )),
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineThickness: 2,
              dashLength: 2,
              dashColor: dividerColor,
            ),
            SizedBox(height: 5),
            // Saved places section
            ListTile(
              dense: true,
              title: Text(
                tr.Translations.of(context).savedLocations,
                style: headingStyle,
              ),
              subtitle: Text(
                tr.Translations.of(context).savedLocationsDescription,
                style: descriptionStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayOverviewWidget extends StatelessWidget {
  const TodayOverviewWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, child) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherSection(
                  title: tr.Translations.of(context).weatherOverview,
                  child: SizedBox()),
              // Weather Now
              WeatherSection(
                title: tr.Translations.of(context).weatherNow,
                child: provider.available
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          WeatherContainer(
                            displayedData:
                                "${provider.openWeatherResponse.current.weather[0].description.capitalize()}",
                            leadingIcon: Icon(
                              openWeatherIcon(provider.openWeatherResponse
                                  .current.weather.first.icon),
                              color: Colors.amberAccent,
                              size: 30,
                            ),
                          ),
                          WeatherContainer(
                            displayedData:
                                "${(provider.openWeatherResponse.current.temp - 273.15).toStringAsFixed(1)}",
                            description:
                                "${tr.Translations.of(context).feelsLike} ${(provider.openWeatherResponse.current.temp - 273.15).toStringAsFixed(1)}",
                            leadingIcon: Icon(
                              MdiIcons.chiliMedium,
                              color: Colors.yellow[300],
                              size: 30,
                            ),
                            trailingIcon: Icon(
                              MdiIcons.temperatureCelsius,
                              color: Colors.white.withOpacity(0.9),
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LoadingShimmer(
                              height: 40,
                              width:
                                  MediaQuery.of(context).size.width / 2 - 20),
                          LoadingShimmer(
                              height: 40,
                              width:
                                  MediaQuery.of(context).size.width / 2 - 20),
                        ],
                      ),
              ),
              // Geolocation
              WeatherSection(
                title: tr.Translations.of(context).geolocationData,
                child: Column(
                  children: [
                    provider.available
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WeatherContainer(
                                description: "Longitude",
                                leadingIcon: Icon(
                                  MdiIcons.longitude,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                displayedData: provider.position.longitude
                                    .toStringAsFixed(2),
                              ),
                              SizedBox(width: 10),
                              WeatherContainer(
                                description: "Latitude",
                                leadingIcon: Icon(
                                  MdiIcons.latitude,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                displayedData: provider.position.latitude
                                    .toStringAsFixed(2),
                              ),
                              SizedBox(width: 10),
                              WeatherContainer(
                                description: "Altitude",
                                leadingIcon: Icon(
                                  MdiIcons.imageFilterHdr,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                displayedData: provider.position.altitude
                                    .toStringAsFixed(2),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20),
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20),
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20),
                            ],
                          ),
                    SizedBox(height: 10),
                    // Sunset sunrise
                    provider.available
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WeatherContainer(
                                description: "Sunset",
                                leadingIcon: Icon(
                                  MdiIcons.weatherSunsetUp,
                                  size: 40,
                                  color: Colors.yellow[200],
                                ),
                                displayedData:
                                    "${DateTime.fromMillisecondsSinceEpoch(provider.openWeatherResponse.current.sunrise * 1000).hour}:${DateTime.fromMillisecondsSinceEpoch(provider.openWeatherResponse.current.sunrise * 1000).minute}",
                              ),
                              SizedBox(width: 10),
                              WeatherContainer(
                                description: "Sunrise",
                                leadingIcon: Icon(
                                  MdiIcons.weatherSunsetDown,
                                  size: 40,
                                  color: Colors.yellow[600],
                                ),
                                displayedData:
                                    "${DateTime.fromMillisecondsSinceEpoch(provider.openWeatherResponse.current.sunset * 1000).hour}:${DateTime.fromMillisecondsSinceEpoch(provider.openWeatherResponse.current.sunset * 1000).minute}",
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20),
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20),
                            ],
                          ),
                  ],
                ),
              ),
              // Atmosphere
              WeatherSection(
                title: tr.Translations.of(context).atmosphericData,
                child: Column(
                  children: [
                    provider.available
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WeatherContainer(
                                description: "Clouds [%]",
                                leadingIcon: Icon(
                                  MdiIcons.cloud,
                                  size: 30,
                                  color: Colors.blueGrey[100],
                                ),
                                displayedData: provider
                                    .openWeatherResponse.current.clouds
                                    .toStringAsFixed(2),
                              ),
                              SizedBox(width: 10),
                              WeatherContainer(
                                description: "Visibility [m]",
                                leadingIcon: Icon(
                                  MdiIcons.telescope,
                                  size: 30,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                displayedData: provider
                                    .openWeatherResponse.current.visibility
                                    .toStringAsFixed(0),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20),
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20),
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 3 -
                                      20),
                            ],
                          ),
                    SizedBox(height: 10),
                    // Sunset sunrise
                    provider.available
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WeatherContainer(
                                description: "Humidity [%]",
                                leadingIcon: Icon(
                                  MdiIcons.airHumidifier,
                                  size: 30,
                                  color: Colors.blueGrey[50],
                                ),
                                displayedData:
                                    "${provider.openWeatherResponse.current.humidity}",
                              ),
                              SizedBox(width: 10),
                              WeatherContainer(
                                description: "Dew point",
                                leadingIcon: Icon(
                                  MdiIcons.waterAlert,
                                  size: 30,
                                  color: Colors.blueGrey[50],
                                ),
                                trailingIcon: Icon(
                                  MdiIcons.temperatureCelsius,
                                  color: Colors.white.withOpacity(0.9),
                                  size: 30,
                                ),
                                displayedData:
                                    "${(provider.openWeatherResponse.current.dewPoint - 273.15).toStringAsFixed(1)}",
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20),
                              LoadingShimmer(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      20),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherContainer extends StatelessWidget {
  final Icon leadingIcon;
  final Icon trailingIcon;
  final String displayedData;
  final String description;

  WeatherContainer({
    Key key,
    @required this.leadingIcon,
    this.trailingIcon,
    @required this.displayedData,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var background = Theme.of(context).canvasColor;
    var headingStyle = textTheme.headline5.copyWith(
        color: calculateContrastColor(background, Colors.black, Colors.white));
    var descriptionStyle = textTheme.caption.copyWith(
        color: calculateContrastColor(background, Colors.black.withOpacity(0.8),
            Colors.white.withOpacity(0.8)));

    return Row(
      children: [
        leadingIcon,
        SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                displayedData,
                style: headingStyle,
              ),
            ),
            if (description != null) ...[
              SizedBox(height: 2),
              Text(
                description,
                style: descriptionStyle,
              ),
            ],
          ],
        ),
        if (trailingIcon != null) ...[
          SizedBox(
            width: 0,
          ),
          trailingIcon
        ],
      ],
    );
  }
}

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key key, @required this.height, @required this.width})
      : super(key: key);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SkeletonAnimation(
        child: Container(
          width: width,
          height: height,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

// class WeatherGrid extends StatelessWidget {
//   const WeatherGrid({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return // TESTING GRID
//         SliverPadding(
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       sliver: SliverGrid(
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
//           mainAxisSpacing: 0,
//           crossAxisSpacing: 0,
//           childAspectRatio: 3.0,
//         ),
//         delegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             return WeatherContainer(
//                 leadingIcon: Icon(
//                   MdiIcons.weatherSunny,
//                   size: 40,
//                   color: Colors.amber,
//                 ),
//                 trailingIcon: Random.secure().nextBool()
//                     ? null
//                     : Icon(
//                         MdiIcons.temperatureCelsius,
//                         size: 30,
//                         color: Colors.amber,
//                       ),
//                 displayedData: "Clear Sky",
//                 description: Random.secure().nextBool() ? "clear" : null);
//           },
//           childCount: 20,
//         ),
//       ),
//     );
//   }
// }

class WeatherSection extends StatelessWidget {
  final Widget child;
  final String title;
  const WeatherSection({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var background = Theme.of(context).canvasColor;

    var bigHeadingStyle = textTheme.headline6
        .copyWith(
            color:
                calculateContrastColor(background, Colors.black, Colors.white))
        .copyWith(fontFamily: GoogleFonts.getFont('Rubik Mono One').fontFamily);
    var dividerColor = calculateContrastColor(background,
        Colors.black.withOpacity(0.3), Colors.white.withOpacity(0.3));

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            title,
            style: bigHeadingStyle,
          ),
          Icon(
            MdiIcons.unfoldMoreHorizontal,
            color: Colors.white24,
          ),
        ]),
        SizedBox(height: 5),
        // Container for weather now
        child,

        SizedBox(
          height: 10,
        ),
        DottedLine(
          direction: Axis.horizontal,
          lineThickness: 2,
          dashLength: 2,
          dashColor: dividerColor,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
