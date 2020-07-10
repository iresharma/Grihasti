import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/OfferBox.dart';
import 'package:customerappgrihasti/components/ProductCard.dart';
import 'package:customerappgrihasti/components/feelingBox.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

	TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
								height: 45,
								decoration: BoxDecoration(
									color: Colors.grey.shade200,
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
										floatingLabelBehavior: FloatingLabelBehavior.never,
										labelText: 'Search...'
									),
									controller: _controller,
									onChanged: (value) => print(value),
								),
							)
						],
					),
				),
				Container(
					color: Colors.grey.shade100,
					height: MediaQuery.of(context).size.height -252,
					child: ListView.builder(
						primary: true,
						itemCount: Top.length + 1,
						itemBuilder: (context, index) {
							if(index == 0) {
								return Column(
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
										FeelingBox(
											text: 'Happiness to be delivered soon',
											asset: 'assets/svg/Orders.svg',
											redirect: 'Check your orders',
										),
										Container(
											margin: EdgeInsets.only(
												top: 30,
												bottom: 10
											),
											padding: EdgeInsets.all(5),
											height: 50,
											decoration: BoxDecoration(
												color: Colors.grey.shade200
											),
											width: MediaQuery.of(context).size.width,
											child: ListView(
												scrollDirection: Axis.horizontal,
												children: <Widget>[
													Align(
														alignment: Alignment.center,
														child: FlatButton(
															child: Text(
																'Top products',
																style: TextStyle(
																	fontWeight: FontWeight.w800,
																	fontSize: 20,
																	color: primaryMain
																),
															),
															onPressed: () => print('change'),
														)
													),
													SizedBox(width: 10,),
													Align(
														alignment: Alignment.center,
														child: FlatButton(
															child: Text(
																'Categories',
																style: TextStyle(
																	fontWeight: FontWeight.w400,
																	fontSize: 20,
																),
															),
															onPressed: () => print('change'),
														),
													),
													SizedBox(width: 10,),
													Align(
														alignment: Alignment.center,
														child: FlatButton(
															child: Text(
																'Offers',
																style: TextStyle(
																	fontWeight: FontWeight.w400,
																	fontSize: 20
																),
															),
															onPressed: () => print('he'),
														)
													),
													SizedBox(width: 10,),
													Align(
														alignment: Alignment.center,
														child: FlatButton(
															child: Text(
																'Hot Deals',
																style: TextStyle(
																	fontWeight: FontWeight.w400,
																	fontSize: 20
																),
															),
															onPressed: () => print('g'),
														)
													),
													SizedBox(width: 10,),
													Align(
														alignment: Alignment.center,
														child: FlatButton(
															child: Text(
																'Previously ordered',
																style: TextStyle(
																	fontWeight: FontWeight.w400,
																	fontSize: 20
																),
															),
															onPressed: () => print('hi'),
														)
													),
													SizedBox(width: 30,),
												],
											),
										),
									],
								);
							}
							else return ProductCard();
						},
					),
				)
			],
		)
	);
  }
}

