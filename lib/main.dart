import 'package:customerappgrihasti/Services/localAuth.dart';
import 'package:customerappgrihasti/Services/router.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Services/dynamicLinks.dart';
import 'Services/freebaseCloudMessaging.dart';

FirebaseAnalytics analytics = FirebaseAnalytics();
String launch = 'Normal';

void main() => runApp(GrihastiApp());

class GrihastiApp extends StatefulWidget {
  @override
  _GrihastiAppState createState() => _GrihastiAppState();
}

class _GrihastiAppState extends State<GrihastiApp> {

  void startup() async {
    initFCM();
    await initLA();
    await loadData();
    await handleDynamicLink();
  }

  @override
  Widget build(BuildContext context) {
    startup();
    return MaterialApp(
      title: 'Grihasti',
      initialRoute: '/',
      routes: Router(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.redAccent
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.redAccent
      ),
    );
  }
}
