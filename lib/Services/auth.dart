import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:customerappgrihasti/views/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'freebaseCloudMessaging.dart';
import 'globalVariables.dart';

final GoogleSignIn _googleSignIn = new GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignIn(BuildContext context) async {
	final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
	final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

	final AuthCredential credential = GoogleAuthProvider.getCredential(
		accessToken: googleAuth.accessToken,
		idToken: googleAuth.idToken,
	);

	final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
	Activeuser.Name = user.displayName;
	Activeuser.photoUrl = user.photoUrl;
	Activeuser.Email = user.email;
	Activeuser.Uid = user.uid;
	Activeuser.Noti = Noti;
	await Firestore.instance.collection('users').document(user.uid).get().then((value) async {
		if(value.exists) {
			Activeuser.Tel = value.data['Tel'] ?? '';
			Activeuser.cart = value.data['cart'] ?? [];
			Activeuser.address = value.data['address'] ?? [];
		}
		else {
			print('hi2');
			await Firestore.instance.collection('users').document(user.uid).setData({
				'Name' : user.displayName,
				'photoUrl' : user.photoUrl,
				'Email' : user.email,
				'Noti' : Noti,
				'cred' : credential
			});
		}
	});
	Navigator.of(context).pushReplacement(
		new MaterialPageRoute(
			builder: (_) => HomeScreen()
		)
	);
	return user;
}