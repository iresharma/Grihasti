import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/dynamicLinks.dart';
import 'package:customerappgrihasti/Services/filterFirebaseData.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/localAuth.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:customerappgrihasti/views/HomeScreen.dart';
import 'package:customerappgrihasti/views/introScroll.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  List<Color> colors = [Colors.blue, Colors.teal, Colors.yellow, Colors.green];

  final Geolocator geolocator = Geolocator();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () async {
      geolocator
          .getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        locationPermissionLevel: GeolocationPermission.locationWhenInUse,
      )
          .then((Position position) {
        print('${position.latitude}, ${position.longitude}');
        Geolocator()
            .placemarkFromCoordinates(position.latitude, position.longitude,
                localeIdentifier: 'en')
            .then((value) => {
                  print(
                      '======${value[0].locality}, ${value[0].subLocality}======'),
                  Location = '${value[0].locality}, ${value[0].subLocality}'
                });
        geolocator
            .distanceBetween(
                position.latitude, position.longitude, 22.623621, 88.353856)
            .then((loc) {
          print(loc);
          if (loc <= 10000) {
            FirebaseAuth.instance.currentUser().then((value) {
              if (value == null) {
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (_) => IntroScroller()));
              } else {
                Firestore.instance
                    .collection('users')
                    .document(value.uid)
                    .get()
                    .then((user) {
                  print(user.data);
                  if (user.data['Name'] != null) {
                    Activeuser.Uid = value.uid;
                    order();
                    Activeuser.Name = user.data['Name'];
                    Activeuser.Email = user.data['Email'];
                    Activeuser.address = user.data['Address'];
                    Activeuser.Tel = value.phoneNumber;
                    Activeuser.coins = user.data['coins'] ?? 0;
                    Provider.of<CartItem>(context).deProcess(user.data['Cart']);
                    Provider.of<Search>(context)
                        .process(user.data['searched'] ?? []);
                    startup().then((data) => Navigator.of(context)
                        .pushReplacement(new MaterialPageRoute(
                            builder: (_) => HomeScreen())));
                  } else {
                    Activeuser.Name = user.data['Name'];
                    startup().then((data) => Navigator.of(context)
                        .pushReplacement(new MaterialPageRoute(
                            builder: (_) => HomeScreen())));
                  }
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (_) => HomeScreen()));
                });
              }
            });
          } else
            Navigator.of(context).pushReplacementNamed('/not_serving');
        });
      }).catchError((onError) => {
                Fluttertoast.showToast(
                    msg: 'Please turn on location and restart the app',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0),
                Future.delayed(Duration(milliseconds: 300),
                    () => AppSettings.openLocationSettings())
              });
    });
  }

  Future<void> startup() async {
    initFCM();
    await hotDeals();
    await topProducts();
    await category();
    await offerProducts();
    await offereded();
    initLA();
    await handleDynamicLink();
    searchFire(context);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 712, width: 360, allowFontScaling: false);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/SplashBack.jpg',
            fit: BoxFit.cover,
          ),
          Transform.translate(
            offset: Offset(0, ScreenUtil().setSp(200)),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('G',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.3,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Calli2')),
                        Text('rihasti',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.2,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Calli'))
                      ],
                    ),
                    Text(
                      'आपका सामान, आपकी दुकान',
                      style: TextStyle(
                        color: primaryMain,
                        fontSize: 25.0,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Raleway',
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: ColorLoader(
                        colors: colors,
                        duration: Duration(milliseconds: 500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
