import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
		child: Text(
			'Profile',
			style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
		),
	);
  }
}
