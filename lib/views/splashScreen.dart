import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:customerappgrihasti/views/HomeScreen.dart';
import 'package:customerappgrihasti/views/introScroll.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

	List<Color> colors = [
		Colors.blue,
		Colors.teal,
		Colors.yellow,
		Colors.green
	];

	@override
  void initState() {
    super.initState();
    Timer(
		Duration(seconds: 3),
		() async {
			Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
			GeolocationStatus geolocationStatus  = await geolocator.checkGeolocationPermissionStatus();
			Position post = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
			double loc = await Geolocator().distanceBetween(post.longitude, post.latitude, 88.354382, 22.623758);
//			88.352357, 22.636997,
			print(loc.toString());
			if(loc <= 10000) {
				FirebaseAuth.instance.currentUser().then((value) {
					if( value == null) {
						Navigator.of(context).pushReplacement(
							new MaterialPageRoute(
								builder: (_) => IntroScroller()
							)
						);
					}
					else {
						Firestore.instance.collection('users').document(value.uid).get()
							.then((user) {
							print(user.data['Name']);
							Activeuser.Name = user.data['Name'];
							Activeuser.Email = user.data['Email'];
							Activeuser.address = user.data['Address'];
							Activeuser.Tel = value.phoneNumber;
							Provider.of<CartItem>(context).deProcess(user.data['Cart']);
							Navigator.of(context).pushReplacement(
								new MaterialPageRoute(
									builder: (_) => HomeScreen()
								)
							);
						});
					}
				});
			}
			else Navigator.of(context).pushReplacementNamed('/not_serving');
		}
	);
  }
  @override
  Widget build(BuildContext context) {
	  return Scaffold(
		  backgroundColor: primaryMain,
		  body: Center(
			  child: Column(
				  mainAxisAlignment: MainAxisAlignment.center,
				  mainAxisSize: MainAxisSize.max,
				  children: <Widget>[
					  Row(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  mainAxisAlignment: MainAxisAlignment.center,
						  children: <Widget>[
							  Text(
								  'G',
								  style: TextStyle(
									  color: secondaryMain,
									  fontSize: MediaQuery.of(context).size.width * 0.3,
									  fontWeight: FontWeight.w400,
									  fontFamily: 'Calli2'
								  )
							  ),
							  Text(
								  'rihasti',
								  style: TextStyle(
									  color: secondaryMain,
									  fontSize: MediaQuery.of(context).size.width * 0.2,
									  fontWeight: FontWeight.w400,
									  fontFamily: 'Calli'
								  )
							  )
						  ],
					  ),
					  Text(
						  'आपका सामान, आपकी दुकान',
						  style: TextStyle(
							  color: secondarySec,
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
	  );
  }
}

