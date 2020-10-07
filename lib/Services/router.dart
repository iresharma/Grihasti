import 'package:customerappgrihasti/views/NotServing.dart';
import 'package:customerappgrihasti/views/OrdersPage.dart';
import 'package:customerappgrihasti/views/addInfo.dart';
import 'package:customerappgrihasti/views/cart.dart';
import 'package:customerappgrihasti/views/search.dart';
import 'package:customerappgrihasti/views/splashScreen.dart';
import 'package:customerappgrihasti/views/viewOrder.dart';
import 'package:customerappgrihasti/views/productList.dart';
import 'package:customerappgrihasti/views/SearchResult.dart';
import 'package:customerappgrihasti/views/productPAge.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> Router() {
	var router = {
		'/' : (_) => Splash(),
		'/cart': (_) => CartPage(),
		'/edit': (_) => Addinfo(),
		'/orders': (_) => OrdersPage(),
		'/search': (_) => SearchPage(),
		'/not_serving': (_) => NotServing(),
		'/list': (_) => ProductList(),
		'/searchResult': (_) => SearchResult(),
		'/product': (_) => ProductPage()
	};

	return router;
}