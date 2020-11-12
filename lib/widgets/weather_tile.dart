import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherTile extends StatefulWidget {
  WeatherTile({Key key}) : super(key: key);

  @override
  _WeatherTileState createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.shortestSide / 2;
    return Container(
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          Container(height: 50, width: 50, child: Text("je;;")),
        ],
      ),
    );
  }
}
