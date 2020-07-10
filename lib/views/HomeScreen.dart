import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/OfferBox.dart';
import 'package:customerappgrihasti/components/ProductCard.dart';
import 'package:customerappgrihasti/components/feelingBox.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Products.dart';
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
	bool Topp;
	bool Offers;
	bool Hot;
	bool Prev;

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Topp = true;
    Offers = false;
    Hot = false;
    Prev = false;
  }

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
											if(Provider.of<CartItem>(context).len == 0)...{
												FeelingBox(
													text: 'It feels very lonely here',
													asset: 'assets/svg/emptyCart.svg',
													redirect: 'Shop now',
												)
											}
											else...{
												FeelingBox(
													text: 'Things are ready to be launched',
													asset: 'assets/svg/filledCart.svg',
													redirect: 'Place your order',
												)
											},
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
																		fontWeight: Topp ? FontWeight.w800 : FontWeight.w400,
																		fontSize: 20,
																		color: Topp ? primaryMain : Colors.black54
																	),
																),
																onPressed: () {
																	setState(() {
																		Topp = true;
																		Offers = false;
																		Hot = false;
																		Prev = false;
																	});
																},
															)
														),
														SizedBox(width: 10,),
														Align(
															alignment: Alignment.center,
															child: FlatButton(
																child: Text(
																	'Offers',
																	style: TextStyle(
																		fontWeight: Offers ? FontWeight.w800 : FontWeight.w400,
																		fontSize: 20,
																		color: Offers ? primaryMain : Colors.black54
																	),
																),
																onPressed: () {
																	setState(() {
																		Topp = false;
																		Offers = true;
																		Hot = false;
																		Prev = false;
																	});
																},
															)
														),
														SizedBox(width: 10,),
														Align(
															alignment: Alignment.center,
															child: FlatButton(
																child: Text(
																	'Hot Deals',
																	style: TextStyle(
																		fontWeight: Hot ? FontWeight.w800 : FontWeight.w400,
																		fontSize: 20,
																		color: Hot ? primaryMain : Colors.black54
																	),
																),
																onPressed: () {
																	setState(() {
																		Topp = false;
																		Offers = false;
																		Hot = true;
																		Prev = false;
																	});
																},
															)
														),
														SizedBox(width: 10,),
														Align(
															alignment: Alignment.center,
															child: FlatButton(
																child: Text(
																	'Previously ordered',
																	style: TextStyle(
																		fontWeight: Prev ? FontWeight.w800 : FontWeight.w400,
																		fontSize: 20,
																		color: Prev ? primaryMain : Colors.black54
																	),
																),
																onPressed: () {
																	setState(() {
																		Topp = false;
																		Offers = false;
																		Hot = false;
																		Prev = true;
																	});
																},
															)
														),
														SizedBox(width: 30,),
													],
												),
											),
										],
									);
								}
								else return ProductCard(index - 1);
							},
						),
					)
				],
			)
		),
	);
  }
}

