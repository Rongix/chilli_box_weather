import 'package:flutter/material.dart';
import 'package:weatherApp/Models/compact_location_weather.dart';

// It presents horizontal listview that collapses and expands items based on current selection.
// Items have minimal width. Color, opacity, text elements are animated and animate after selection change.

class WeatherOverviewPicker extends StatefulWidget {
  final Duration duration;
  final List<CompactLocationWeather> locations;

  WeatherOverviewPicker({
    Key key,
    @required this.locations,
    @required this.duration,
  }) : super(key: key);

  @override
  _WeatherOverviewPickerState createState() => _WeatherOverviewPickerState();
}

class _WeatherOverviewPickerState extends State<WeatherOverviewPicker> {
  var active = 0;
  @override
  Widget build(BuildContext context) {
    var tabPart = 8;
    switch (widget.locations.length) {
      case 1:
        tabPart = 8;
        break;
      case 2:
        tabPart = 7;
        break;
      case 3:
        tabPart = 6;
        break;
      default:
        tabPart = 5;
        break;
    }
    var activeTabWidth = MediaQuery.of(context).size.width / 8 * tabPart;
    var inactiveTabWidth = MediaQuery.of(context).size.width / 8 * 1;

    return Container(
      color: Theme.of(context).canvasColor,
      height: 250,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          ...widget.locations
              .asMap()
              .map((i, item) => MapEntry(
                  i,
                  GestureDetector(
                    onTap: () {
                      print('$i tapped');
                      setState(() {
                        active = i;
                      });
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: active == i ? 50 : 0,
                      child: AnimatedContainer(
                        width: active == i ? activeTabWidth : inactiveTabWidth,
                        decoration: active == i
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.orangeAccent,
                                      Colors.deepOrange
                                    ]),
                                borderRadius: BorderRadius.circular(0),
                              )
                            : BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.blueGrey.shade400,
                                      Colors.blueGrey.shade400,
                                    ]),
                                borderRadius: BorderRadius.circular(0),
                              ),
                        duration: Duration(milliseconds: 150),
                        child: active == i
                            ? HorizontalDescription(text: item.locationName)
                            : VerticalDescription(text: item.locationName),
                      ),
                    ),
                  )))
              .values
        ],
      ),
    );
  }
}

class HorizontalDescription extends StatelessWidget {
  final String text;

  const HorizontalDescription({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class VerticalDescription extends StatelessWidget {
  final String text;
  const VerticalDescription({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}
