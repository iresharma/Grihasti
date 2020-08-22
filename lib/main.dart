import 'package:customerappgrihasti/Services/filterFirebaseData.dart';
import 'package:customerappgrihasti/Services/localAuth.dart';
import 'package:customerappgrihasti/Services/router.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Services/dynamicLinks.dart';
import 'Services/freebaseCloudMessaging.dart';
import 'Services/lifecyclemanager.dart';
import 'models/Search.dart';

FirebaseAnalytics analytics;

void main() => runApp(ChangeNotifierProvider(
	builder: (context) => CartItem(),
	child: GrihastiApp(),
));

class GrihastiApp extends StatefulWidget {
	@override
	_GrihastiAppState createState() => _GrihastiAppState();
}

class _GrihastiAppState extends State<GrihastiApp> {

	void startup() async {
		initFCM();
		hotDeals();
		topProducts();
		category();
		await initLA();
		await handleDynamicLink();
		analytics = FirebaseAnalytics();
		analytics.logAppOpen();
	}

	@override
	Widget build(BuildContext context) {
		startup();
		return LifeCycleManager(
			cart: Provider.of<CartItem>(context).process,
			child: ChangeNotifierProvider(
				builder: (context) => Search(),
				child: MaterialApp(
					title: 'Grihasti',
					initialRoute: '/',
					routes: Router(),
					theme: ThemeData(
							brightness: Brightness.light,
							primaryColor: Color(0xFFFF3F47),
							accentColor: Colors.redAccent,
							canvasColor: Colors.transparent
					),
					darkTheme: ThemeData(
							brightness: Brightness.light,
							primaryColor: Color(0xFFFF3F47),
							accentColor: Colors.redAccent,
							canvasColor: Colors.transparent
					),
				),
			),
		);
	}
}
