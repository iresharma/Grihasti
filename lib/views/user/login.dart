import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/auth.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/components/btnWithIcon.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/components/loaderfade.dart';
import 'package:customerappgrihasti/main.dart';
import 'package:customerappgrihasti/views/app.dart';
import 'package:customerappgrihasti/views/user/register.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:steel_crypt/steel_crypt.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

	bool animate;
	double height;
	bool showPass;
	bool validateE;
	bool validateP;
	String pass;

	final _formKey = GlobalKey<FormState>();

	@override
	void initState() {
		super.initState();
		animate = false;
		showPass = false;
		validateE = false;
		validateP = false;
	}

  	@override
  	Widget build(BuildContext context) {
		final ThemeData theme = Theme.of(context);
		var mode = theme.brightness;
		return Scaffold(
			body: Builder(
				builder: (context) =>
					SingleChildScrollView(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							children: <Widget>[
								AnimatedContainer(
									width: MediaQuery.of(context).size.width,
									height: animate ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.33,
									duration: Duration(milliseconds: 100),
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
									padding: EdgeInsets.symmetric(
										horizontal: 30
									),
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
													TextFormField(
														validator: (value) {
															if(value.isEmpty) {
																return 'Please Enter text';
															}
//															else if(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
//																return 'Input valid email address';
//															}
															else {
																User['Email'] = value;
															}
															return null;
														},
														keyboardType: TextInputType.emailAddress,
														keyboardAppearance: mode,
														decoration: InputDecoration(
															icon: Icon(FlutterIcons.email_box_mco),
															hintText: 'Your email address'
														),
														autovalidate: validateE,
														onChanged: (val) {
															setState(() {
																validateE = true;
															});
														},
													),
													Column(
														mainAxisAlignment: MainAxisAlignment.center,
														children: <Widget>[
															TextFormField(
																validator: (value) {
																	if(value.isEmpty) {
																		return 'Please Enter text';
																	}
																	else if(value.length < 6) {
																		return 'Password must 6 characters long';
																	}
																	else {
																		pass = value;
																	}
																	return null;
																},
																keyboardType: TextInputType.visiblePassword,
																obscureText: !showPass,
																keyboardAppearance: mode,
																onChanged: (val) {
																	setState(() {
																		validateP = true;
																	});
																},
																decoration: InputDecoration(
																	icon: Icon(FlutterIcons.passport_mco),
																	hintText: 'Your password',
																	suffixIcon: IconButton(
																		icon: Icon(FlutterIcons.eye_ant),
																		onPressed: () {
																			setState(() {
																				showPass = !showPass;
																			});
																		},
																	)
																),
																autovalidate: validateP,
															),
															Align(
																alignment: Alignment.centerRight,
																child: FlatButton(
																	child: Text(
																		'Forgot passowrd ?',
																		style: TextStyle(
																			fontSize: 10
																		),
																	),
																	onPressed: () => print('Forgot passowrd'),
																),
															)
														],
													),
													Container(
														margin: EdgeInsets.symmetric(vertical: 0),
														child: Column(
															mainAxisAlignment: MainAxisAlignment.center,
															children: <Widget>[
																SimpleRoundIconButton(
																	buttonText: Text(
																		'Login',
																		style: TextStyle(
																			fontSize: 20,
																			color: Colors.white
																		),
																	),
																	backgroundColor: primaryMain,
																	icon: Icon(FlutterIcons.login_ant),
																	onPressed: () => login(context),
																	iconAlignment: Alignment.centerRight,
																),
																SimpleRoundIconButton(
																	buttonText: Text(
																		'Use google',
																		style: TextStyle(
																			fontSize: 18,
																			color: Colors.white
																		),
																	),
																	backgroundColor: Colors.blueAccent,
																	icon: Icon(FlutterIcons.google_ant),
																	onPressed: () {
																		setState(() {
																		  animate = true;
																		});
																		handleSignIn();
																	},
																	iconAlignment: Alignment.centerRight,
																)
															],
														),
													),
													FlatButton(
														child: Text(
															'Don\'t have an account, Register?',
															style: TextStyle(
																fontSize: 13
															),
														),
														onPressed: () => Navigator.of(context).pushNamed(
															'/register',
															arguments: RegS('', '')
														),
													),
												],
											),
										),
									),
								),
							],
						),
					),
			),
		);
  	}

  void login(BuildContext context) async {
		if(_formKey.currentState.validate()) {
			Firestore.instance.collection('customer').where('Email', isEqualTo: User['Email']).getDocuments().then((onValue) {
				var hasher = HashCrypt('sha256');
				var passHash = hasher.hash(pass);
				if(onValue.documents.length != 0) {
					onValue.documents.forEach((user) async {
						if(user.data['passHash'].toString() == passHash.toString()) {
							setState(() {
								animate = true;
							});
							User['Name'] = user.data['Name'];
							User['Uid'] = user.documentID;
							User['PhotoUrl'] = user.data['PhotoUrl'];
							User['Tel'] = user.data['Tel'].toString();
							if(user.data['Noti'] != Noti) {
								Firestore.instance.collection('customer').document(user.documentID).updateData({
									'Token': Noti
								});
							}
							writeData({
								'Uid' : user.data['Uid'].toString(),
								'Name' : user.data['name'],
								'PhotoUrl': user.data['PhtotUrl'],
								'Tel': user.data['Tel'].toString(),
								'logged' : "true"
							});
							await analytics.logLogin();
							Navigator.of(context).pushReplacement(
								new MaterialPageRoute(
									builder: (_) => App()
								)
							);
						}
						else {
							Scaffold.of(context).showSnackBar(SnackBar(
								content: Container(
									height: 15,
									child: Text(
										'Incorrext password',
										style: TextStyle(
											color: Colors.red
										),
									),
								),
								duration: Duration(seconds: 2),
							));
						}
					});
				}
				else {
					Scaffold.of(context).showSnackBar(SnackBar(
						content: Container(
							height: 15,
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									Text(
										'User not found'
									),
									FlatButton(
										child: Text(
											'Register'
										),
										onPressed: () => Navigator.of(context).pushNamed(
											'/register',
											arguments: RegS(pass, User['Email'])
										),
									)
								],
							),
						),
						duration: Duration(seconds: 2),
					));
				}
			});
		}
  }
}
