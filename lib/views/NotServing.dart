import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:customerappgrihasti/views/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/models/Cart.dart';

import 'HomeScreen.dart';
import 'introScroll.dart';

class NotServing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.grey.shade200,
		appBar: PreferredSize(
			child: Builder(
				builder: (context) => AppBar(
					backgroundColor: Colors.transparent,
					elevation: 0,
					flexibleSpace: SafeArea(
						child: Hero(
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
							tag: 'Logo',
						),
					),
				),
			),
			preferredSize: Size.fromHeight(80.0)
		),
		body: Container(
			height: MediaQuery.of(context).size.height,
			width: MediaQuery.of(context).size.width,
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				crossAxisAlignment: CrossAxisAlignment.center,
				children: <Widget>[
					Container(
						padding: EdgeInsets.only(
							top: 40,
							left: 40,
							right: 40,
							bottom: 20
						),
						child: Text(
							'Sorry we don\'t serve here yet',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(20),
								fontWeight: FontWeight.bold,
								color: primaryMain
							),
						),
					),
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Icon(
								FlutterIcons.location_evi,
								color: primaryMain,
								size: 30,
							),
							Text(
								Location,
								style: TextStyle(color: primaryMain, fontSize: 17),
							),
						],
					),
					SvgPicture.asset(
						'assets/svg/noService.svg',
						width: MediaQuery.of(context).size.width * 0.6,
					),
					FlatButton(
						child: Text('Explore our options ?'),
						onPressed: () => showDialog(
							context: context,
							builder: (context) => AlertDialog(
								title: Text(
									'WARNING',
									style: TextStyle(
										color: primaryMain
									),
								),
								content: Text('Any ordered placed with the address outside our service area will be immediately cancelled'),
								actions: <Widget>[
									FlatButton(
										child: Text('Proceed'),
										onPressed: () => FirebaseAuth.instance.currentUser().then((value) {
											if( value == null) {
												Navigator.of(context).pushReplacement(
														new MaterialPageRoute(
																builder: (_) => IntroScroller()
														)
												);
											}
											else {
												Firestore.instance.collection('users').document(value.uid).get()
														.then((user) {
													print(user.data['Name']);
													Activeuser.Uid = value.uid;
													Activeuser.Name = user.data['Name'];
													Activeuser.Email = user.data['Email'];
													Activeuser.address = user.data['Address'];
													Activeuser.Tel = value.phoneNumber;
													Activeuser.coins = user.data['coins'] ?? 0;
													Provider.of<CartItem>(context).deProcess(user.data['Cart']);
													Navigator.of(context).pushReplacement(
															new MaterialPageRoute(
																	builder: (_) => HomeScreen()
															)
													);
												});
											}
										}),
									)
								],
							)
						),
					)
				],
			),
		),
	);
  }
}
