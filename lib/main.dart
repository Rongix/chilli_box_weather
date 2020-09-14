import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'Views/Android/AndroidApp.dart';
import 'Views/iOS/iOSApp.dart';

var providersList = <SingleChildWidget>[];

void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent, // navigation bar color
        statusBarColor: Colors.transparent // status bar color
        ));
    runApp(MultiProvider(providers: providersList, child: AndroidApp()));
  } else if (Platform.isIOS) {
    runApp(MultiProvider(providers: providersList, child: IOSApp()));
  }
}
