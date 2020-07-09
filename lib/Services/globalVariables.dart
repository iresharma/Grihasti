import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

Map<String, dynamic> User = {
	"Name": '',
	"Uid": '',
	"PhotoUrl": '',
	"Coins": 0,
	"Tel": '',
	"Address": [],
	'Email': ''
};

Widget landing;

List<Map<String, BiometricType>> available = [];

Color primaryMain = Color(0xFFCC1A18);
Color primarySec = Colors.redAccent;
Color secondaryMain = Colors.white;
Color secondarySec = Colors.yellow;


Future<void> getUser() async {
	if(await storage.read(key: 'logged') == 'true') {
		await Firestore.instance.collection('customer').document(await storage.read(key: 'Uid')).get().then((user) => {
			print('Hello ${user.data}'),
			User['Name'] = user.data['Name'],
			User['PhotoUrl'] = user.data['PhotoUrl'],
			User['Tel'] = user.data['Tel'],
			User['Email'] = user.data['Email']
		});
		print('loaded $User');
	}
}


List<Products> Top = [];

List<Products> Prev = [];