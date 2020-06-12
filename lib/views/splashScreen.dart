import 'dart:async';

import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

	List<Color> colors = [
		Colors.blue,
		Colors.pink,
		Colors.yellow,
		Colors.green
	];

	@override
  void initState() {
    super.initState();
    Timer(
		Duration(seconds: 2),
		() => Navigator.of(context).pushReplacement(
			new MaterialPageRoute(
				builder: (_) => landing
			)
		)
	);
  }
  @override
  Widget build(BuildContext context) {
	  return Scaffold(
		  backgroundColor: primaryMain,
		  body: Center(
			  child: Column(
				  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				  children: <Widget>[
					  ColorLoader(
						  colors: colors,
						  duration: Duration(milliseconds: 500),
					  )
				  ],
			  ),
		  ),
	  );
  }
}

