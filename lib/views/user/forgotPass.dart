import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Center(
			child: Text(
				'Forgot Pass',
				style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
			),
		),
	);
  }
}
