import 'dart:async';
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
		Duration(seconds: 3),
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

