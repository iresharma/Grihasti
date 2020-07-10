import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/OfferBox.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.grey.shade200,
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
									color: Colors.black45,
									fontSize: MediaQuery.of(context).size.width * 0.15,
									fontWeight: FontWeight.w400,
									fontFamily: 'Calli2',
								)
							),
							Text(
								'rihasti',
								style: TextStyle(
									color: Colors.black45,
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
						onPressed: () => print('task'),
					)
				],
			),
			preferredSize: Size.fromHeight(80.0)
		),
		body: Column(
			children: <Widget>[
				Container(
					padding: EdgeInsets.all(10),
					child: Column(
						children: <Widget>[
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									Icon(
										FlutterIcons.location_evi,
										color: primaryMain,
										size: 30,
									),
									Text(
										'Howrahlkadslgna;rigbd;uvbdvnf',
										style: TextStyle(
											color: primaryMain,
											fontSize: 17
										),
									)
								],
							),
							Container(
								height: 40,
								decoration: BoxDecoration(
									color: Colors.white,
									borderRadius: BorderRadius.circular(5)
								),
								padding: EdgeInsets.only(
									left: 10
								),
								margin: EdgeInsets.all(20),
								child: TextField(
									decoration: InputDecoration(
										border: InputBorder.none,
										icon: Icon(FlutterIcons.search1_ant),
										labelText: 'Search...'
									),
								),
							)
						],
					),
				),
				SingleChildScrollView(
					child: Column(
						children: <Widget>[
							Container(
								width: MediaQuery.of(context).size.width,
								height: 120,
								padding: EdgeInsets.all(0),
								child: ListView.builder(
									scrollDirection: Axis.horizontal,
									itemCount: 5,
									itemBuilder: (context, index) {
										return OfferBox(
											'500 off.',
											index,
											'Some more information, probably long',
										);
									},
								),
							),
						],
					),
				)
			],
		)
	);
  }
}
