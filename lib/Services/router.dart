import 'package:customerappgrihasti/views/NotServing.dart';
import 'package:customerappgrihasti/views/OrdersPage.dart';
import 'package:customerappgrihasti/views/addInfo.dart';
import 'package:customerappgrihasti/views/cart.dart';
import 'package:customerappgrihasti/views/splashScreen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> Router() {
	var router = {
		'/' : (_) => Splash(),
		'/cart': (_) => CartPage(),
		'/edit': (_) => Addinfo(),
		'/orders': (_) => OrdersPage(),
		'/not_serving': (_) => NotServing()
	};

	return router;
}