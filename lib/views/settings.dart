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
												title: Text('Change Password'),
												leading: Image.asset('assets/icons/change_pass.png'),
												onTap: () => Navigator.of(context).push(
													MaterialPageRoute(builder: (_) => ChangePasswordPage())),
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
			Paint()..color = Color.fromRGBO(253, 184, 70, 0.7));

	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) {
		return false;
	}
}


class ChangePasswordPage extends StatefulWidget {
	@override
	_ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
	@override
	Widget build(BuildContext context) {
		double width = MediaQuery.of(context).size.width;
		double bottomPadding = MediaQuery.of(context).padding.bottom;

		Widget changePasswordButton = InkWell(
			onTap: () {},
			child: Container(
				height: 80,
				width: width / 1.5,
				decoration: BoxDecoration(
					gradient: LinearGradient(colors: [
						Color.fromRGBO(236, 60, 3, 1),
						Color.fromRGBO(234, 60, 3, 1),
						Color.fromRGBO(216, 78, 16, 1),
					],
						begin: FractionalOffset.topCenter,
						end: FractionalOffset.bottomCenter
					),
					boxShadow: [
						BoxShadow(
							color: Color.fromRGBO(0, 0, 0, 0.16),
							offset: Offset(0, 5),
							blurRadius: 10.0,
						)
					],
					borderRadius: BorderRadius.circular(9.0)),
				child: Center(
					child: Text("Confirm Change",
						style: const TextStyle(
							color: const Color(0xfffefefe),
							fontWeight: FontWeight.w600,
							fontStyle: FontStyle.normal,
							fontSize: 20.0)),
				),
			),
		);

		return Scaffold(
			backgroundColor: Colors.grey[100],
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
					builder: (b, constraints) => Padding(
						padding: const EdgeInsets.symmetric(horizontal: 16.0),
						child: SingleChildScrollView(
							child: ConstrainedBox(
								constraints: BoxConstraints(minHeight: constraints.maxHeight),
								child: Column(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Padding(
													padding: const EdgeInsets.only(bottom: 48.0,top:16.0),
													child: Text(
														'Change Password',
														style: TextStyle(
															color: Colors.black,
															fontWeight: FontWeight.bold,
															fontSize: 18.0),
													),
												),
												Padding(
													padding: const EdgeInsets.only(bottom: 12.0),
													child: Text(
														'Enter your current password',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
												),
												Container(
													padding: const EdgeInsets.symmetric(
														horizontal: 16.0, vertical: 8.0),
													decoration: BoxDecoration(
														color: Colors.white,
														borderRadius:
														BorderRadius.all(Radius.circular(5))),
													child: TextField(
														decoration: InputDecoration(
															border: InputBorder.none,
															hintText: 'Existing Password',
															hintStyle: TextStyle(fontSize: 12.0)),
													)),
												Padding(
													padding:
													const EdgeInsets.only(top: 24, bottom: 12.0),
													child: Text(
														'Enter new password',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
												),
												Container(
													padding: const EdgeInsets.symmetric(
														horizontal: 16.0, vertical: 8.0),
													decoration: BoxDecoration(
														color: Colors.white,
														borderRadius:
														BorderRadius.all(Radius.circular(5))),
													child: TextField(
														decoration: InputDecoration(
															border: InputBorder.none,
															hintText: 'New Password',
															hintStyle: TextStyle(fontSize: 12.0)),
													)),
												Padding(
													padding:
													const EdgeInsets.only(top: 24, bottom: 12.0),
													child: Text(
														'Retype new password',
														style: TextStyle(fontWeight: FontWeight.bold),
													),
												),
												Container(
													padding: const EdgeInsets.symmetric(
														horizontal: 16.0, vertical: 8.0),
													decoration: BoxDecoration(
														color: Colors.white,
														borderRadius:
														BorderRadius.all(Radius.circular(5))),
													child: TextField(
														decoration: InputDecoration(
															border: InputBorder.none,
															hintText: 'Retype Password',
															hintStyle: TextStyle(fontSize: 12.0)),
													)),
											],
										),
										Align(
											alignment: Alignment.bottomCenter,
											child: Container(
												padding: EdgeInsets.only(
													top: 8.0,
													bottom: bottomPadding != 20 ? 20 : bottomPadding),
												width: width,
												child: Center(child: changePasswordButton),
											),
										),
									],
								),
							),
						),
					),
				)),
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