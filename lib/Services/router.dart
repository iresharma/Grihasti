import 'package:customerappgrihasti/views/Profile.dart';
import 'package:customerappgrihasti/views/splashScreen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> Router() {
	var router = {
		'/' : (_) => Splash(),
		'/profile': (_) => ProfilePage()
	};

	return router;
}