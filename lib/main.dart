import 'package:customerappgrihasti/Services/globalVariables.dart';
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

FirebaseAnalytics analytics;

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
    await getUser();
    await handleDynamicLink();
    analytics = FirebaseAnalytics();
    analytics.logAppOpen();
  }

  @override
  Widget build(BuildContext context) {
    startup();
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Grihasti',
      initialRoute: '/',
      routes: Router(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFCC1A18),
        accentColor: Colors.redAccent
      ),
      darkTheme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFCC1A18),
        accentColor: Colors.redAccent
      ),
    );
  }
}
