// Sections are movable elemets of interface. Can change visibiulity of child items when they are disabled

import 'package:flutter/material.dart';

class WeatherSection extends StatelessWidget {
  final String title;

  const WeatherSection({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child:
                Text(this.title, style: Theme.of(context).textTheme.headline1)),
      ],
    );
  }
}
