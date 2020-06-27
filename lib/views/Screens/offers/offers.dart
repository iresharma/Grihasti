import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
		child: Center(
			child: Text(
				'die bitch',
				style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
			),
		),
	);
  }
}
