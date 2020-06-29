import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/btn1.dart';
import 'package:customerappgrihasti/components/btnIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductPAge extends StatefulWidget {

	final String productId;
	final String name;

  const ProductPAge({Key key, this.productId, this.name}) : super(key: key);

  @override
  _ProductPAgeState createState() => _ProductPAgeState();
}

class _ProductPAgeState extends State<ProductPAge> {

	bool active;

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    active = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			title: Text(widget.name),
			actions: <Widget>[
				IconButton(
					icon: Icon(FlutterIcons.share_2_fea),
					color: Colors.white,
					onPressed: () => print('share'),
				),
				IconButton(
					icon: FlutterBadge(
						itemCount: 5,
						icon: Icon(
							FlutterIcons.cart_mco,
							color: Colors.white,
						),
						badgeColor: Colors.greenAccent,
						borderRadius: 20,
						badgeTextColor: primaryMain,
					),
					onPressed: () => print('Cart'),
				)
			],
		),
		body: Container(
			height: MediaQuery.of(context).size.height,
			width: MediaQuery.of(context).size.width,
			child: SingleChildScrollView(
				child: Column(
					mainAxisSize: MainAxisSize.max,
					children: <Widget>[
						FutureBuilder(
							future: Firestore.instance.collection('product').document(widget.productId).get(),
							builder: (context, snapshot) {
								if(!snapshot.hasData) {
									return Container(
										height: MediaQuery.of(context).size.height,
										child: Center(
											child: CircularProgressIndicator(),
										),
									);
								}
								else {
									print(snapshot.data.exists);
									return SingleChildScrollView(
										child:Column(
											mainAxisSize: MainAxisSize.max,
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Container(
													height: MediaQuery.of(context).size.height/2,
													decoration: BoxDecoration(
														borderRadius: BorderRadius.only(
															bottomLeft: Radius.circular(10),
															bottomRight: Radius.circular(10)
														)
													),
													child: Center(
														child: Image.network(
															snapshot.data.data['Pic'],
															height: MediaQuery.of(context).size.height/2,
															scale: 0.2,
														)
													),
												),
												SizedBox(height: 10,),
												Text(
													widget.name,
													style: TextStyle(
														fontWeight: FontWeight.w900,
														fontSize: 65
													),
													overflow: TextOverflow.ellipsis,
												),
												SizedBox(height: 15,),
												Container(
													color: Colors.grey[300],
													padding: EdgeInsets.all(20),
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: <Widget>[
															Text(
																'Description',
																style: TextStyle(
																	fontSize: 25,
																	fontWeight: FontWeight.w600
																),
															),
															Divider(thickness: 2.5,),
															SizedBox(height: 10,),
															Text(
																snapshot.data.data['Desc'],
																style: TextStyle(
																	fontSize: 20,
																	fontWeight: FontWeight.w200
																),
															),
															SizedBox(height: 30,),
															Row(
																children: <Widget>[
																	Text(
																		'Variety :',
																		style: TextStyle(
																			fontSize: 30,
																			fontWeight: FontWeight.w600
																		)
																	),
																	SizedBox(width: 10,),
																	CupertinoButton(
																		color: Colors.black,
																		padding: EdgeInsets.all(2),
																		child: Text('5 Kg'),
																		onPressed: () {
																			setState(() {
																				active = !active;
																			});
																		},
																	),
																	SizedBox(width: 10,),
																	CupertinoButton(
																		color: active ? Colors.yellow : Colors.black,
																		padding: EdgeInsets.all(4),
																		child: Text(
																			'10 Kg',
																			style: TextStyle(
																				color: !active ? Colors.yellow : Colors.black,
																			),
																		),
																		onPressed: () {
																			setState(() {
																				active = !active;
																			});
																		},
																	),
																	SizedBox(width: 10,),
																	CupertinoButton(
																		color: Colors.black,
																		padding: EdgeInsets.all(4),
																		child: Text('15 Kg'),
																		onPressed: () {
																			setState(() {
																				active = !active;
																			});
																		},
																	)
																],
															),
														],
													),
												),
												SizedBox(height: 30,),
												Padding(
													padding: EdgeInsets.all(10),
													child: Row(
														crossAxisAlignment: CrossAxisAlignment.center,
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														children: <Widget>[
															Text(
																'Price: ',
																style: TextStyle(
																	fontSize: 45,
																	fontWeight: FontWeight.w700
																)
															),
															Container(
																child: Row(
																	children: <Widget>[
																		Text(
																			'₹ 400',
																			style: TextStyle(
																				decoration: TextDecoration.lineThrough,
																				fontSize: 30,
																				fontWeight: FontWeight.w100
																			),
																		),
																		SizedBox(width: 10,),
																		Container(
																			decoration: BoxDecoration(
																				borderRadius: BorderRadius.circular(20),
																				color: Colors.green
																			),
																			padding: EdgeInsets.all(8),
																			child: Text(
																				'₹ 345',
																				style: TextStyle(
																					fontSize: 30,
																					fontWeight: FontWeight.w700
																				)
																			),
																		),
																	],
																),
															)
														],
													),
												),
											],
										),
									);
								}
							},
						)
					],
				),
			),
		),
		bottomNavigationBar: BottomAppBar(
			child: Container(
				height: 70,
				padding: EdgeInsets.only(bottom: 10),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						Container(
							child: FlatButton(
								child: Icon(
									FlutterIcons.cart_plus_mco,
									size: 30,
								),
								onPressed: () => print('added'),
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(100)
								),
							),
							decoration: BoxDecoration(
								color: Colors.deepOrange,
								borderRadius: BorderRadius.circular(100)
							),
						),
						Container(
							width: MediaQuery.of(context).size.width * 0.75,
							child: FlatButton(
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(100)
								),
								child: Row(
									crossAxisAlignment: CrossAxisAlignment.center,
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[
										Icon(
											FlutterIcons.basket_unfill_mco,
											color: Colors.white,
											size: 25,
										),
										SizedBox(width: 10,),
										Text(
											'Buy now',
											style: TextStyle(
												color: Colors.white,
												fontSize: 20
											),
										)
									],
								),
								onPressed: () => print('added'),
							),
							decoration: BoxDecoration(
								color: primaryMain,
								borderRadius: BorderRadius.circular(100)
							),
						),
					],
				),
			),
		),
	);
  }
}
