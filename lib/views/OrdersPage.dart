import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Container(
			height: MediaQuery.of(context).size.height,
			color: Colors.white,
			child: orders.length == 0 ? SvgPicture.asset(
				'assets/svg/emptyOrder.svg',
				width: MediaQuery.of(context).size.height * 0.8,
			) : ListView.builder(
				itemCount: orders.length,
				itemBuilder: (context, index) {
					return Text(orders[index].price.toString());
				},
			),
		),
	);
  }
}
