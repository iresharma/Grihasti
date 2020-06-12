import 'package:customerappgrihasti/views/splashScreen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> Router() {
	var router = {
		'/' : (_) => Splash(),
	};

	return router;
}