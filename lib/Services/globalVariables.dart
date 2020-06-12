import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';

Map<String, dynamic> User = {
	"name": '',
	"uid": '',
	"photoUrl": '',
	"Coins": 0,
	"tel": '',
	"Address": []
};

Widget landing;

List<Map<String, BiometricType>> available = [];