import 'package:flutter/material.dart';
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

double devheight = 0;
double devwidth = 0;

Color primaryMain = Color(0xFFCC1A18);
Color primarySec = Colors.redAccent;
Color secondaryMain = Colors.white;
Colors secondarySec;