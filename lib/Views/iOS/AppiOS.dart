import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherApp/Constants/translation.dart' as tr;

class AppiOS extends StatelessWidget {
  const AppiOS({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: tr.localizationDelegates,
      supportedLocales: tr.supportedLocales,
      title: 'Photo Print Layout',
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomeiOS(),
    );
  }
}

class HomeiOS extends StatelessWidget {
  const HomeiOS({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(tr.Translations.of(context).test),
      ),
    );
  }
}
