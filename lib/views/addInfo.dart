import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Addinfo extends StatefulWidget {
  @override
  _AddinfoState createState() => _AddinfoState();
}

class _AddinfoState extends State<Addinfo> {

	GlobalKey<FormState> key = new GlobalKey<FormState>();
	TextEditingController Name = new TextEditingController();
	TextEditingController Email = new TextEditingController();
	TextEditingController Address = new TextEditingController();
	TextEditingController Tel = new TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey.shade200,
			appBar: CustAppBar(),
			body: SingleChildScrollView(
				child: Form(
					key: key,
					child: Padding(
						padding: EdgeInsets.all(20),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							crossAxisAlignment: CrossAxisAlignment.center,
							children: <Widget>[
								CircleAvatar(
									radius: 50,
									child: Activeuser.photoUrl == null
										? Image.asset(
										'assets/images/avataaars.png')
										: Image.network(Activeuser.photoUrl),
								),
								TextFormField(
									controller: Name,
									decoration: InputDecoration(
										icon: Icon(FlutterIcons.profile_ant),
										labelText: 'Name',
										fillColor: Colors.grey.shade400
									),
									validator: (value) {
										if (value.isEmpty) {
											return 'Cannot be empty';
										}
										else {
											Activeuser.Name = value;
											return null;
										}
									},
								),
								TextFormField(
									controller: Email,
									decoration: InputDecoration(
										icon: Icon(FlutterIcons.email_box_mco),
										labelText: 'Email',
										fillColor: Colors.grey.shade400,
									),
									keyboardType: TextInputType.emailAddress,
									validator: (value) {
										if (value.isEmpty) {
											return 'Cannot be empty';
										}
										else {
											Activeuser.Email = value;
											return null;
										}
									},
								),
								TextFormField(
									controller: Tel,
									decoration: InputDecoration(
										icon: Icon(
											FlutterIcons.phone_android_mdi),
										labelText: 'Phone number',
										fillColor: Colors.grey.shade400
									),
									keyboardType: TextInputType.numberWithOptions(),
//									initialValue: Activeuser.Tel,
									validator: (value) {
										if (value.isEmpty) {
											return 'Cannot be empty';
										}
										else {
											Activeuser.Tel = value;
											return null;
										}
									},
								),
								TextFormField(
									controller: Address,
									decoration: InputDecoration(
										icon: Icon(
											FlutterIcons.home_account_mco),
										labelText: 'Address',
										fillColor: Colors.grey.shade400
									),
									maxLines: 5,
									validator: (value) {
										if (value.isEmpty) {
											return 'Cannot be empty';
										}
										else {
											Activeuser.address = value;
											return null;
										}
									},
								),
								SizedBox(
									height: MediaQuery.of(context).size.height/15,
								),
								OutlineButton.icon(
									icon: Icon(FlutterIcons.check_all_mco),
									label: Text('Save'),
									onPressed: () {
										if(key.currentState.validate()) {
											var cart = Provider.of<CartItem>(context).process;
											FirebaseAuth.instance.currentUser()
												.then((value) {
													Firestore.instance.collection('users').document(value.uid).updateData({
														'Email': Activeuser.Email,
														'Address': Activeuser.address,
														'Name': Activeuser.Name,
														'Cart': cart
														});
													Navigator.of(context).pop();
												}
											);
										}
									},
								)
							],
						),
					),
				),
			),
		);
	}
}

