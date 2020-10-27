import 'package:customerappgrihasti/Services/router.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Services/lifecyclemanager.dart';
import 'models/Search.dart';

FirebaseAnalytics analytics;

void main() => runApp(ChangeNotifierProvider(
      builder: (context) => CartItem(),
      child: GrihastiApp(),
    ));

class GrihastiApp extends StatefulWidget {
  @override
  _GrihastiAppState createState() => _GrihastiAppState();
}

class _GrihastiAppState extends State<GrihastiApp> {
  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      cart: Provider.of<CartItem>(context).process,
      child: ChangeNotifierProvider(
        builder: (context) => Search(),
        child: MaterialApp(
          title: 'Grihasti',
          initialRoute: '/',
          routes: Router(),
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Color(0xFFFF3F47),
              accentColor: Colors.redAccent,
              canvasColor: Colors.transparent),
          darkTheme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Color(0xFFFF3F47),
              accentColor: Colors.redAccent,
              canvasColor: Colors.transparent),
        ),
      ),
    );
  }
}
