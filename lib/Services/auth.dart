import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'globalVariables.dart';

final GoogleSignIn _googleSignIn = new GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignIn() async {
	final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
	final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

	final AuthCredential credential = GoogleAuthProvider.getCredential(
		accessToken: googleAuth.accessToken,
		idToken: googleAuth.idToken,
	);

	final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
	print("signed in " + user.displayName);
	User['Name'] = user.displayName;
	User['PhotoUrl'] = user.photoUrl;
	User['Email'] = user.email;
	Firestore.instance.collection('customer').where('Email', isEqualTo: user.email).getDocuments().then((onValue) => {
		if(onValue.documents.length != 0) {
			onValue.documents.forEach((data) => {
				writeData({
				'Uid': data.documentID,
				'logged': 'true'
				}),
				if(data.data['Token'] != Noti) {
					Firestore.instance.collection('customer').document(data.documentID).updateData({
						'Token': Noti
					})
				},
				if(data.data['PhotoUrl'] != user.photoUrl) {
					Firestore.instance.collection('customer').document(data.documentID).updateData({
						'PhotoUrl': user.photoUrl
					})
				}
			})
		}
		else {
			writeData({
			'Uid': user.uid.toString(),
			'logged': 'true'
			}),
			Firestore.instance.collection('customer').document(user.uid.toString()).setData({
				'Email': user.email,
				'PhotoUrl': user.photoUrl,
				'Name': user.displayName,
				'Tel': 0,
				'Token': Noti
			})
		}
	});
	return user;
}