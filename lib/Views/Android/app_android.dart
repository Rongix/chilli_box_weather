import 'package:flutter/material.dart';
import 'package:infinity_ui/infinity_ui.dart';

import 'package:weatherApp/Constants/translation.dart' as tr;
import 'package:weatherApp/Models/OpenWeather.dart';
import 'package:weatherApp/widgets/custom_refresh_indicator.dart';

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

var widgetList = [
  Container(
    height: 200,
    color: Colors.blue[300],
    child: Center(child: Text("Daily Weather")),
  ),
  Container(
    height: 200,
    color: Colors.blue[300],
    child: Center(child: Text("Weekly Weather")),
  ),
  Container(
    height: 200,
    color: Colors.blue[300],
    child: Center(child: Text("Perticipation %")),
  ),
];

class HomeAndroid extends StatelessWidget {
  const HomeAndroid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
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
            CustomRefreshIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.white.withOpacity(0.5),
              onRefresh: () {
                return Future.delayed(Duration(milliseconds: 2000));
              },
              child: Padding(
                padding: EdgeInsets.only(top: InfinityUi.statusBarHeight),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        "Zabrze",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.blue[200],
                      floating: false,
                      pinned: true,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue[300], Colors.blue[200]],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                        ),
                        collapseMode: CollapseMode.none,
                        centerTitle: false,
                      ),
                      expandedHeight: MediaQuery.of(context).size.height / 3,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => widgetList[index],
                          childCount: widgetList.length),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
