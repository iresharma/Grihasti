import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/components/loaderfade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

	bool animate;
	double height;

	final _formKey = GlobalKey<FormState>();

	@override
  void initState() {
    super.initState();
    animate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Column(
			mainAxisAlignment: MainAxisAlignment.start,
			children: <Widget>[
				AnimatedContainer(
					width: MediaQuery.of(context).size.width,
					height: animate ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.33,
					duration: Duration(milliseconds: 250),
					decoration: BoxDecoration(
						color: primaryMain,
						borderRadius: BorderRadius.only(
							bottomLeft: Radius.circular(20),
							bottomRight: Radius.circular(20)
						)
					),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.center,
						children: <Widget>[
							Text(
								'GRIHASTI',
								style: TextStyle(
									color: secondaryMain,
									fontSize: 80.0,
									fontWeight: FontWeight.w500,
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
							animate ? Column(
								children: <Widget>[
									SizedBox(height: 60,),
									ColorLoader5(),
									Text(
										'Logging in',
										style: TextStyle(
											fontSize: 15,
											color: secondaryMain
										),
									)
								],
							) : SizedBox(height: 5,)
						],
					),
				),
				animate ? Container() : Container(
					height: MediaQuery.of(context).size.height * 0.67,
					decoration: BoxDecoration(
						color: Colors.transparent
					),
					child: Padding(
						padding: EdgeInsets.symmetric(
							vertical: 30
						),
						child: Form(
							key: _formKey,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: <Widget>[
									Text(
										'LOGIN',
										style: TextStyle(
											color: Colors.grey,
											fontWeight: FontWeight.w600,
											fontSize: 30
										),
									),
									TextFormField(),
									TextFormField(),
									OutlineButton.icon(
										onPressed: () {
											print('hey');
											setState(() {
												animate = true;
											});
										},
										icon: Icon(FlutterIcons.login_ant),
										label: Text('Login')
									)
								],
							),
						),
					),
				),
			],
		),
	);
  }
}
