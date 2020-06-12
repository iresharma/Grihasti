import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: Center(
			child: Text(
				'App',
				style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
			),
		),
	);
  }
}
