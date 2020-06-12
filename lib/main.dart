import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/freebaseCloudMessaging.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() => runApp(GrihastiApp());

class GrihastiApp extends StatefulWidget {
  @override
  _GrihastiAppState createState() => _GrihastiAppState();
}

class _GrihastiAppState extends State<GrihastiApp> {
  @override
  Widget build(BuildContext context) {
    initFCM();
//    Firestore.instance.collection('test').document().setData({
//      'data': 'test data'
//    });
      var _razorPay = new Razorpay();
    return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Hey',
              style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
          ),
        )
    );
  }
}
