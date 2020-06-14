import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/auth.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/btnWithIcon.dart';
import 'package:customerappgrihasti/views/user/login.dart';
import 'package:customerappgrihasti/views/user/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:steel_crypt/steel_crypt.dart';

class ForgotPass extends StatefulWidget {

	final String uid;

	ForgotPass(this.uid) {
		User['Uid'] = uid;
	}

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

	TextEditingController _one = new TextEditingController();
	TextEditingController _two = new TextEditingController();

	final _form = new GlobalKey<FormState>();

	bool isShow;
	String pass;

	@override
  void initState() {
    super.initState();
    isShow = false;
    pass = '';
  }

  void passChange(pass, context) async {
		var hasher = HashCrypt('sha256');
		var passHash = hasher.hash(pass);
		Firestore.instance.collection('customer').document(User['Uid']).updateData({
			'passHash': passHash
		});
		Navigator.of(context).pushReplacement(
			new MaterialPageRoute(
				builder: (_) => Login()
			)
		);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			leading: IconButton(
				icon: Icon(CupertinoIcons.back),
				onPressed: () => Navigator.of(context).pop(),
			),
			elevation: 0,
		),
		body: SingleChildScrollView(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.start,
				children: <Widget>[
					AnimatedContainer(
						width: MediaQuery.of(context).size.width,
						duration: Duration(milliseconds: 100),
						height: MediaQuery.of(context).size.height * 0.15,
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
							],
						),
					),
					Container(
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
								key: _form,
								child: Column(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
									children: <Widget>[
										Text(
											'FORGOT PASSWORD',
											style: TextStyle(
												color: Colors.grey,
												fontWeight: FontWeight.w600,
												fontSize: 30
											),
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
													obscureText: !isShow,
													keyboardAppearance: Theme.of(context).brightness,
													decoration: InputDecoration(
														icon: Icon(FlutterIcons.lock_fea),
														hintText: 'New password',
														suffixIcon: IconButton(
															icon: Icon(FlutterIcons.eye_ant),
															onPressed: () {
																setState(() {
																	isShow = !isShow;
																});
															},
														)
													),
													autovalidate: true,
												),
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
													obscureText: !isShow,
													keyboardAppearance: Theme.of(context).brightness,
													decoration: InputDecoration(
														icon: Icon(FlutterIcons.lock_fea),
														hintText: 'Confirm new password',
														suffixIcon: IconButton(
															icon: Icon(FlutterIcons.eye_ant),
															onPressed: () {
																setState(() {
																	isShow = !isShow;
																});
															},
														)
													),
													autovalidate: true,
												),
												Align(
													alignment: Alignment.centerRight,
													child: FlatButton(
														child: Text(
															'Login ?',
															style: TextStyle(
																fontSize: 10
															),
														),
														onPressed: () => Navigator.of(context).pushNamed('/login'),
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
														onPressed: () => passChange(pass, context),
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
														onPressed: () => handleSignIn(),
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
	);
  }
}
