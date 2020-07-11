import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
		builder: (context) => Scaffold(
			backgroundColor: Colors.white,
			appBar: PreferredSize(
				child: AppBar(
					backgroundColor: Colors.transparent,
					leading: IconButton(
						icon: Icon(FlutterIcons.align_left_fea, color: Colors.black38,),
						onPressed: () => Scaffold.of(context).openDrawer(),
					),
					elevation: 0,
					flexibleSpace: SafeArea(
						child: Row(
							crossAxisAlignment: CrossAxisAlignment.start,
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								Text(
									'G',
									style: TextStyle(
										color: Colors.black54,
										fontSize: MediaQuery.of(context).size.width * 0.15,
										fontWeight: FontWeight.w400,
										fontFamily: 'Calli2',
									)
								),
								Text(
									'rihasti',
									style: TextStyle(
										color: Colors.black54,
										fontSize: MediaQuery.of(context).size.width * 0.13,
										fontWeight: FontWeight.w400,
										fontFamily: 'Calli'
									)
								)
							],
						),
					),
					actions: <Widget>[
						IconButton(
							icon: Icon(FlutterIcons.search1_ant,color: Colors.black38,),
							onPressed: () => print('search'),
						),
						IconButton(
							icon: FlutterBadge(
								itemCount: Provider.of<CartItem>(context).len,
								badgeColor: Colors.greenAccent,
								icon: Icon(FlutterIcons.cart_evi, size: 35, color: Colors.black38,),
								badgeTextColor: Colors.black38,
								contentPadding: EdgeInsets.all(7),
							),
							onPressed: () => Navigator.of(context).pushNamed('/cart'),
						)
					],
				),
				preferredSize: Size.fromHeight(80.0)
			),
			drawer: Drawer(
				child: SafeArea(
					child: Column(
						children: <Widget>[
							Text('hello')
						],
					),
				),
			),
			body: PageView(
				children: <Widget>[
					HOme(),
					Center(
						child: Text(
							'Page2',
							style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
						),
					)
				],
			)
		),
	);
  }
}

