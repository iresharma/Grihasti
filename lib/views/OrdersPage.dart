import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Container(
			height: 500,
			color: Colors.white,
			child: ListView.builder(
				itemCount: orders.length,
				itemBuilder: (context, index) {
					return Text(orders[index].price.toString());
				},
			),
		),
	);
  }
}
