import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			title: Text('GRIHASTI'),
			actions: <Widget>[
				Hero(
					child: IconButton(
						icon: FlutterBadge(
							itemCount: cartItem.length,
							icon: Icon(
								FlutterIcons.cart_mco,
								color: Colors.white,
							),
							badgeColor: Colors.greenAccent,
							borderRadius: 20,
							badgeTextColor: primaryMain,
						),
						onPressed: () => Navigator.of(context).pop(),
					),
					tag: 'cart button',
				)
			],
		),
		body: ListView.builder(
			itemCount: cartItem.length,
			itemBuilder: (context, index) {
				print(cartItem[index]);
				return Dismissible(
					key: Key(cartItem[index]['Id']),
					onDismissed: (direction) {
						setState(() {
						  cartItem.removeAt(index);
						});
					},
					child: Container(
						height: MediaQuery.of(context).size.height/6 ,
						margin: EdgeInsets.all(5),
						padding: EdgeInsets.all(5),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(10),
							color: Colors.white70
						),
						child: Column(
							children: <Widget>[
								Text(
									cartItem[index]['Name']
								),
								Text(
									cartItem[index]['Price']
								),
								Text(
									cartItem[index]['count'].toString()
								)
							],
						),
					),
				);
			},
		),
	);
  }
}
