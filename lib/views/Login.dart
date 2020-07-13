import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/auth.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/components/btnWithIcon.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomeScreen.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

	bool isPressed;
	String vrfCode;
	FirebaseAuth auth = FirebaseAuth.instance;
	int forceResend;

	Future phoneNumberLogin(String Num) {
		auth.verifyPhoneNumber(
			phoneNumber: '+91' + Num,
			timeout: Duration(minutes: 2),
			forceResendingToken: forceResend,
			verificationCompleted: (AuthCredential authC) => auth.signInWithCredential(authC).then((value) {
				if(value.user != null) {
					Firestore.instance.collection('users').document(value.user.uid).setData({
						'tel': '+91'+Num,
						'Noti': Noti
					});
					Activeuser.Tel = Num;
					Activeuser.Noti = Noti;
					Navigator.of(context).pushReplacement(
						new MaterialPageRoute(
							builder: (_) => HomeScreen()
						)
					);
				}
			}),
			verificationFailed: (AuthException ex) {
				FlutterToast toast;
				toast.showToast(child: Text('Error occured while signing in, please try again later'));
			},
			codeSent: (String verificationId, [int forceResendingToken]) async {
				setState(() {
				  vrfCode = verificationId;
				  forceResend = forceResendingToken;
				});
			},
			codeAutoRetrievalTimeout: (String verificationId) {
				setState(() {
				  vrfCode = verificationId;
				});
			}
		);
		setState(() {
			isPressed = true;
		});
	}


	checkManually(String trim) async {
		AuthCredential cred = await PhoneAuthProvider.getCredential(verificationId: vrfCode, smsCode: trim);
			auth.signInWithCredential(cred).then((value) {
				Firestore.instance.collection('user').document(value.user.uid).setData({
					'tel': '+91'+_controller.text.trim(),
					'Noti': Noti
				});
				Activeuser.Tel = _controller.text.trim();
				Activeuser.Noti = Noti;
				Navigator.of(context).pushReplacement(
					new MaterialPageRoute(
						builder: (_) => HomeScreen()
					)
				);
			}
		);
	}

	TextEditingController _controller = new TextEditingController();
	TextEditingController _Otpcontroller = new TextEditingController();

	@override
  void initState() {
    super.initState();
    isPressed = false;
    vrfCode = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Container(
			width: MediaQuery.of(context).size.width,
			height: MediaQuery.of(context).size.height,
			decoration: BoxDecoration(
				gradient: LinearGradient(
					begin: Alignment.topCenter,
					end: Alignment.bottomCenter,
					colors: [
						Color(0xFFFF6847),
						Color(0xFFFF4545),
						Color(0xFFFF3F47),
					]
				)
			),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.center,
				children: <Widget>[
					SizedBox(height: 100,),
					SvgPicture.asset(
						'assets/svg/login.svg',
						width: MediaQuery.of(context).size.width/2,
					),
					SizedBox(height: 50,),
					Stack(
						alignment: Alignment.topCenter,
						overflow: Overflow.visible,
						children: <Widget>[
							Card(
								elevation: 2.0,
								color: Colors.white,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(8.0),
								),
								child: Container(
									width: 300.0,
									height: 190.0,
									child: Column(
										children: <Widget>[
											Padding(
												padding: EdgeInsets.only(
													top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
												child: TextField(
													keyboardType: TextInputType.phone,
													style: TextStyle(
														fontFamily: "WorkSansSemiBold",
														fontSize: 16.0,
														color: Colors.black),
													decoration: InputDecoration(
														border: InputBorder.none,
														icon: Icon(
															Icons.phone,
															color: Colors.black,
															size: 22.0,
														),
														hintText: "Phone Number without +91",
														hintStyle: TextStyle(
															fontFamily: "WorkSansSemiBold", fontSize: 17.0),
													),
													controller: _controller,
												),
											),
											Container(
												width: 250.0,
												height: 1.0,
												color: Colors.grey[400],
											),
											Padding(
												padding: EdgeInsets.only(
													top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
												child: TextField(
													keyboardType: TextInputType.number,
													style: TextStyle(
														fontFamily: "WorkSansSemiBold",
														fontSize: 16.0,
														color: Colors.black),
													controller: _Otpcontroller,
													decoration: InputDecoration(
														border: InputBorder.none,
														icon: Icon(
															Icons.security,
															color: Colors.black.withOpacity(0.2),
															size: 22.0,
														),
														hintText: "OTP",
														hintStyle: TextStyle(
															fontFamily: "WorkSansSemiBold", fontSize: 17.0),
													),
												),
											),
										],
									),
								),
							),
							Container(
								margin: EdgeInsets.only(top: 170.0),
								decoration: new BoxDecoration(
									borderRadius: BorderRadius.all(Radius.circular(5.0)),
									color: Colors.green
								),
								child: MaterialButton(
									highlightColor: Colors.transparent,
									splashColor: Colors.greenAccent,
									//shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
									child: Padding(
										padding: const EdgeInsets.symmetric(
											vertical: 10.0, horizontal: 42.0),
										child: Text(
											isPressed ? 'Check' : 'Get OTP',
											style: TextStyle(
												color: Colors.white,
												fontSize: 25.0,
												fontFamily: "WorkSansBold"),
										),
									),
									onPressed: () => isPressed ? checkManually(_Otpcontroller.text.trim()) : phoneNumberLogin(_controller.text.trim()),
								),
							),
						],
					),
					SizedBox(height: MediaQuery.of(context).size.height/25,),
					Center(
						child: Container(
							width: MediaQuery.of(context).size.width * 0.7,
							child: Row(
								children: <Widget>[
									Expanded(
										child: Divider(
											color: Colors.white,
										)
									),
									SizedBox(width: 10,),
									Text(
										'Or',
										style: TextStyle(
											color: Colors.white,
											fontWeight: FontWeight.w200,
											fontSize: 30
										),
									),
									SizedBox(width: 10,),
									Expanded(
										child: Divider(
											color: Colors.white,
										)
									),
								]
							),
						),
					),
					SizedBox(height: MediaQuery.of(context).size.height/35,),
					Container(
						width: MediaQuery.of(context).size.width * 0.7,
						child: SimpleRoundIconButton(
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
								handleSignIn(context);
							},
							iconAlignment: Alignment.centerRight,
						),
					)
				],
			),
		),
	);
  }

}
