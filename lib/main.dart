import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinity_ui/infinity_ui.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'Providers/weatherProvider.dart';

import 'Views/Android/app_android.dart';

var providersList = <SingleChildWidget>[
  ChangeNotifierProvider(
    create: (_) => WeatherProvider(),
  )
];

void main() async {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await InfinityUi.enable();

    runApp(MultiProvider(providers: providersList, child: AppAndroid()));
  } else if (Platform.isIOS) {
    runApp(MultiProvider(providers: providersList, child: AppAndroid()));
  }
}
