import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/views/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/models/Cart.dart';

class NotServing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
						padding: EdgeInsets.all(40),
						child: Text(
							'Sorry we don\'t serve here yet',
							style: TextStyle(
								fontSize: 20,
								fontWeight: FontWeight.bold,
								color: primaryMain
							),
						),
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
										onPressed: () => Navigator.of(context).pushReplacement(
											new MaterialPageRoute(
												builder: (_) => Login()
											)
										),
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
