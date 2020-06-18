import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
				  mainAxisAlignment: MainAxisAlignment.center,
				  mainAxisSize: MainAxisSize.max,
				  children: <Widget>[
					  AutoSizeText(
						  'GRIHASTI',
						  style: TextStyle(
							  color: secondaryMain,
							  fontSize: 80.0,
							  fontWeight: FontWeight.w700,
							  fontFamily: 'Monospace'
						  )
					  ),
					  Text(
						  'AAPKA SAMAN, AAPKI DUKAN',
						  style: TextStyle(
							  color: secondarySec,
							  fontSize: 15.0,
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

