import 'package:customerappgrihasti/views/splashScreen.dart';
import 'package:customerappgrihasti/views/user/forgotPass.dart';
import 'package:customerappgrihasti/views/user/login.dart';
import 'package:customerappgrihasti/views/user/register.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> Router() {
	var router = {
		'/' : (_) => Splash(),
		'/register': (_) => Registerpage(),
		'/login': (_) => Login(),
	};

	return router;
}