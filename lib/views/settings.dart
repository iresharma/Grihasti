import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Login.dart';

class SettingsPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.grey.shade200,
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
		);
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
											onTap: () => showAboutDialog(
													context: context,
													applicationVersion: '0.1.3',
													applicationIcon: CircleAvatar(
													  child: Image.asset(
													  	'assets/Appicon/Grihasti.png',
													  ),
													),
													applicationName: 'Grihasti',
													applicationLegalese: 'This app is a copyright of Grihasti Co. \n owned by Nirmal Kumar Bhutra.'
													
											),
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