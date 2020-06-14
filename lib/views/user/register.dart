import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/auth.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/components/btnWithIcon.dart';
import 'package:customerappgrihasti/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:steel_crypt/steel_crypt.dart';

import '../app.dart';

class RegS {
	final String pass;
	final String email;

	RegS(this.pass, this.email);

}

class Registerpage extends StatefulWidget {
  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {

	final _form = new GlobalKey<FormState>();

	bool isPass;
	String password;
	bool isLoading;

	@override
  void initState() {
    super.initState();
    isPass = true;
    password = '';
    isLoading = false;
  }

  void register(context) async {
		if(_form.currentState.validate()) {
			Firestore.instance.collection('customer').where('Email', isEqualTo: User['Email']).getDocuments().then((onValue) async {
				if(onValue.documents.length == 0) {
					setState(() {
					  isLoading = true;
					});
					var hasher = HashCrypt('sha256');
					var passHash = hasher.hash(password);
					await Firestore.instance.collection('customer').document().setData({
						'Name': User['Name'],
						'Email': User['Email'],
						'passHash': passHash,
						'Tel': User['tel'],
						'Token': Noti
					});
					await analytics.logSignUp();
					await writeData({
						'Name': User['Name'],
						'Email': User['Email'],
						'passHash': passHash.toString(),
						'Tel': User['tel'],
						'Logged': 'true'
					});
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
								'User already exist,\nPlease login',
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
  }

  @override
  Widget build(BuildContext context) {
  	final RegS args = ModalRoute.of(context).settings.arguments;
  	final Brightness mode = Theme.of(context).brightness;
    return Builder(
		builder: (_) => Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.white,
				elevation: 0,
				iconTheme: IconThemeData(
					color: Colors.black
				),
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.only(
						bottomRight: Radius.circular(20),
						bottomLeft: Radius.circular(20)
					),
				),
				title: Text(
					'GRIHASTI',
					style: TextStyle(
						fontSize: 30,
						fontWeight: FontWeight.w500,
						color: primaryMain
					),
				),
			),
			backgroundColor: Color(0xefffffff),
			body: Stack(
				fit: StackFit.expand,
				children: <Widget>[
					Column(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						mainAxisSize: MainAxisSize.max,
						children: <Widget>[
							Expanded(
								flex: 6,
								child: SingleChildScrollView(
									child: Form(
										key: _form,
										child: Padding(
											padding: EdgeInsets.symmetric(
												vertical: 40,
												horizontal: 30
											),
											child: Column(
												mainAxisAlignment: MainAxisAlignment.spaceAround,
												crossAxisAlignment: CrossAxisAlignment.center,
												children: <Widget>[
													Text(
														'REGISTER',
														style: TextStyle(
															color: Colors.grey,
															fontWeight: FontWeight.w600,
															fontSize: 30
														),
													),
													SizedBox(height: 60,),
													TextFormField(
														validator: (value) {
															if(value.isEmpty) {
																return 'Enter some value';
															}
															User['Name'] = value;
															return null;
														},
														keyboardType: TextInputType.text,
														keyboardAppearance: mode,
														decoration: InputDecoration(
															icon: Icon(FlutterIcons.user_astronaut_faw5s),
															hintText: 'Your name',
														),
													),
													SizedBox(height: 20,),
													TextFormField(
														validator: (value) {
															if(value.isEmpty) {
																return 'Enter some value';
															}
															User['Email'] = value;
															return null;
														},
														keyboardType: TextInputType.emailAddress,
														initialValue: args.email,
														keyboardAppearance: mode,
														decoration: InputDecoration(
															icon: Icon(FlutterIcons.mail_fea),
															hintText: 'Your email address',
														),
													),
													SizedBox(height: 20,),
													TextFormField(
														validator: (value) {
															if(value.isEmpty) {
																return 'Enter some value';
															}
															password = value;
															return null;
														},
														keyboardType: TextInputType.text,
														obscureText: isPass,
														keyboardAppearance: mode,
														decoration: InputDecoration(
															icon: Icon(FlutterIcons.lock1_ant),
															hintText: 'Password',
															labelText: 'Password',
															suffixIcon: IconButton(
																icon: isPass ? Icon(FlutterIcons.eye_ant) : Icon(FlutterIcons.eye_off_fea),
																onPressed: () {
																	setState(() {
																		isPass = !isPass;
																	});
																},
															)
														),
														initialValue: args.pass,
													),
													SizedBox(height: 20,),
													TextFormField(
														validator: (value) {
															if(value.isEmpty) {
																return 'Enter some value';
															}
															if(value != password) {
																return 'Should match password';
															}
															return null;
														},
														keyboardType: TextInputType.text,
														obscureText: isPass,
														keyboardAppearance: mode,
														decoration: InputDecoration(
															icon: Icon(FlutterIcons.lock1_ant),
															hintText: 'Confirm password',
															suffixIcon: IconButton(
																icon: isPass ? Icon(FlutterIcons.eye_ant) : Icon(FlutterIcons.eye_off_fea),
																onPressed: () {
																	setState(() {
																		isPass = !isPass;
																	});
																},
															)
														),
														initialValue: args.pass,
													),
													SizedBox(height: 20,),
													TextFormField(
														validator: (value) {
															if(value.isEmpty) {
																return 'Enter some value';
															}
															User['tel'] = value;
															return null;
														},
														keyboardType: TextInputType.phone,
														keyboardAppearance: mode,
														decoration: InputDecoration(
															icon: Icon(FlutterIcons.phone_fea),
															hintText: 'Your phone number',
														),
													),
												],
											),
										),
									),
								),
							),
							Expanded(
								flex: 2,
								child: Container(
									height: MediaQuery.of(context).size.height/5,
									decoration: BoxDecoration(
										borderRadius: BorderRadius.only(
											topLeft: Radius.circular(20),
											topRight: Radius.circular(20)
										),
										color: Colors.white,
									),
									child: Column(
										children: <Widget>[
											SimpleRoundIconButton(
												buttonText: Text(
													'SignUp with Email',
													style: TextStyle(
														color: primaryMain
													),
												),
												backgroundColor: secondarySec,
												icon: Icon(FlutterIcons.email_box_mco),
												iconAlignment: Alignment.centerRight,
												iconColor: primaryMain,
												onPressed: () => register(context),
											),
											SimpleRoundIconButton(
												buttonText: Text(
													'SignUp with google',
													style: TextStyle(
														color: Colors.white
													),
												),
												backgroundColor: Colors.blueAccent,
												iconColor: Colors.blueAccent,
												iconAlignment: Alignment.centerRight,
												icon: Icon(FlutterIcons.google_ant),
												onPressed: () => handleSignIn(),
											)
										],
									),
								),
							)
						],
					),
					if(isLoading)...{
						Container(
							height: MediaQuery.of(context).size.height,
							child: Center(
								child: CircularProgressIndicator(),
							),
						)
					}
				],
			),
		),
	);
  }
}
