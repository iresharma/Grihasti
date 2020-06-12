import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Center(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Text(
						'login',
						style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
					),
					FlatButton(
						child: Text('login'),
						onPressed: () => writeData({
							"logged": "true"
						}),
					)
				],
			),
		),
	);
  }
}
