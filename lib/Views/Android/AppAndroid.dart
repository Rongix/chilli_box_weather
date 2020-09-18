import 'package:flutter/material.dart';
import 'package:infinity_ui/infinity_ui.dart';

import 'package:weatherApp/Constants/Translation.dart' as tr;
import 'package:weatherApp/Models/OpenWeather.dart';

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
    return Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: InfinityUi.navigationBarHeight),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              OpenWeatherApi.oneCall(
                  lat: 50.30,
                  lon: 18.7,
                  locale: Localizations.localeOf(context));
            },
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: InfinityUi.statusBarHeight),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.blue,
                    floating: true,
                    pinned: true,
                    title: Text("Zabrze"),
                    flexibleSpace: Container(
                      color: Colors.blue,
                      height: 300,
                    ),
                    expandedHeight: 300,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => widgetList[index],
                        // Container(
                        //       height: 100,
                        //       decoration: BoxDecoration(
                        //         gradient: LinearGradient(
                        //             colors: [Colors.orange, Colors.lightBlue],
                        //             transform: GradientRotation(90)),
                        //       ),
                        //     ),
                        childCount: widgetList.length),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

var widgetList = [
  Container(
    height: 300,
    color: Colors.blue[400],
    child: Text("Alamakota"),
  ),
  Container(
    height: 200,
    color: Colors.blue[600],
    child: Row(
      children: [CircularProgressIndicator()],
    ),
  ),
  Container(
    height: 300,
    color: Colors.blue[800],
    child: Text("Alaniemakota"),
  ),
];
