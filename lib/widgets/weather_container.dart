import 'package:flutter/material.dart';

class WeatherContainer extends StatefulWidget {
  final String lolipop;
  WeatherContainer({Key key, @required this.lolipop}) : super(key: key);

  @override
  _WeatherContainerState createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.1),
      child: Row(
        children: [],
      ),
    );
  }
}
