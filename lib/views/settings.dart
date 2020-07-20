import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Login.dart';

class SettingsPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return CustomPaint(
			painter: MainBackground(),
			child: Scaffold(
				appBar: AppBar(
					iconTheme: IconThemeData(
						color: Colors.black,
					),
					brightness: Brightness.light,
					backgroundColor: Colors.transparent,
					title: Text(
						'Settings',
						style: TextStyle(color: Color(0xff202020)),
					),
					elevation: 0,
				),
				body: SafeArea(
					bottom: true,
					child: LayoutBuilder(
						builder:(builder,constraints)=> SingleChildScrollView(
							child: ConstrainedBox(
								constraints: BoxConstraints(minHeight: constraints.maxHeight),
								child: Padding(
									padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Padding(
												padding: const EdgeInsets.only(bottom: 8.0),
												child: Text(
													'General',
													style: TextStyle(
														color: Colors.black,
														fontWeight: FontWeight.bold,
														fontSize: 18.0),
												),
											),
											ListTile(
												title: Text('Legal & About'),
												leading: Image.asset('assets/icons/legal.png'),
												onTap: () => Navigator.of(context).push(
													MaterialPageRoute(builder: (_) => LegalAboutPage())),
											),
											ListTile(
												title: Text('About Us'),
												leading: Image.asset('assets/icons/about_us.png'),
												onTap: (){},
											),
											Padding(
												padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
												child: Text(
													'Account',
													style: TextStyle(
														color: Colors.black,
														fontWeight: FontWeight.bold,
														fontSize: 18.0),
												),
											),
											ListTile(
												title: Text('Sign out'),
												leading: Image.asset('assets/icons/sign_out.png'),
												onTap: () => Navigator.of(context).push(
													MaterialPageRoute(builder: (_) => Login())),
											),

										],
									),
								),
							),
						)
					),
				),
			),
		);
	}
}


class MainBackground extends CustomPainter {

	MainBackground();

	@override
	void paint(Canvas canvas, Size size) {
		double height = size.height;
		double width = size.width;
		canvas.drawRect(
			Rect.fromLTRB(
				0, 0,width, height),
			Paint()..color = Colors.white);
		canvas.drawRect(
			Rect.fromLTRB(
				width - (width / 3), 0,width, height),
			Paint()..color = primaryMain);

	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) {
		return false;
	}
}

class LegalAboutPage extends StatefulWidget {
	@override
	_LegalAboutPageState createState() => _LegalAboutPageState();
}

class _LegalAboutPageState extends State<LegalAboutPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			appBar: AppBar(
				iconTheme: IconThemeData(
					color: Colors.black,
				),
				brightness: Brightness.light,
				backgroundColor: Colors.transparent,
				title: Text(
					'Settings',
					style: TextStyle(color: Color(0xff202020)),
				),
				elevation: 0,
			),
			body: SafeArea(
				bottom: true,
				child: Padding(
					padding: const EdgeInsets.only(top:24.0,left: 24.0, right: 24.0),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: <Widget>[
							Padding(
								padding: const EdgeInsets.only(bottom: 16.0),
								child: Text(
									'Legal & About',
									style: TextStyle(
										color: Colors.black,
										fontWeight: FontWeight.bold,
										fontSize: 18.0),
								),
							),
							Flexible(
								child: ListView(
									children: <Widget>[
										ListTile(
											title: Text('Terms of Use'),
											trailing: Icon(Icons.chevron_right),
										),
										ListTile(
											title: Text('Privacy Policy'),
											trailing: Icon(Icons.chevron_right),
										),
										ListTile(
											title: Text('License'),
											trailing: Icon(Icons.chevron_right),
										),
									],
								),
							),
						],
					),
				),
			),
		);
	}
}