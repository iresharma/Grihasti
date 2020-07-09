import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			leading: IconButton(
				icon: Icon(FlutterIcons.align_left_fea),
				onPressed: () => Scaffold.of(context).openDrawer(),
			),
			title: Text('GRIHASTI'),
			actions: <Widget>[
				IconButton(
					icon: Icon(FlutterIcons.search1_ant),
					onPressed: () => print('search'),
				),
				IconButton(
					icon: FlutterBadge(
						itemCount: Provider.of<CartItem>(context).len,
						badgeColor: Colors.greenAccent,
						icon: Icon(FlutterIcons.cart_evi, size: 35,),
						badgeTextColor: Colors.black38,
						contentPadding: EdgeInsets.all(7),
					),
					onPressed: () => print('task'),
				)
			],
		),
		body: ListView.builder(
			itemCount: 10,
			itemBuilder: (context, index) {
				print(Top);
				if(index == Top.length) {
					return FlatButton(
						child: Text('Profile'),
						onPressed: () => Navigator.pushNamed(context, '/profile'),
					);
				}
				else if (index == Top.length + 1) {
					return FlatButton(
						child: Text('Sign out'),
						onPressed: () => writeData({
							'logged': 'false'
						}),
					);
				}
				else {
					return Container(
						child: Row(
							children: <Widget>[
								Text(Top[index].id),
								Text(Provider.of<CartItem>(context).count(Top[index].id).toString()),
								IconButton(
									icon: Icon(FlutterIcons.cart_plus_mco),
									onPressed: () => Provider.of<CartItem>(context).addToCart(Top[index]),
								)
							],
						),
					);
				}
			},
		),
	);
  }
}
