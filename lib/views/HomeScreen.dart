import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:customerappgrihasti/views/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

	PageController _controller = new PageController();
	int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.white,
		appBar: PreferredSize(
			child: Builder(
				builder: (context) => AppBar(
					backgroundColor: Colors.transparent,
					leading: IconButton(
						icon: Icon(FlutterIcons.align_left_fea, color: Colors.black38,),
						onPressed: () => Scaffold.of(context).openDrawer(),
					),
					elevation: 0,
					flexibleSpace: SafeArea(
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
					),
					actions: <Widget>[
						IconButton(
							icon: Icon(FlutterIcons.search1_ant,color: Colors.black38,),
							onPressed: () => print('hi'),
						),
						IconButton(
							icon: FlutterBadge(
								itemCount: Provider.of<CartItem>(context).len,
								badgeColor: Colors.greenAccent,
								icon: Icon(FlutterIcons.cart_evi, size: 35, color: Colors.black38,),
								badgeTextColor: Colors.black38,
								contentPadding: EdgeInsets.all(7),
							),
							onPressed: () => Navigator.of(context).pushNamed('/cart'),
						)
					],
				),
			),
			preferredSize: Size.fromHeight(80.0)
		),
		drawer: ClipPath(
			clipper: _DrawerClipper(),
			child: Container(
				width: MediaQuery.of(context).size.width -150,
				child: Drawer(
					child: SafeArea(
						child: ListView(
							children: <Widget>[
								Container(
									height: MediaQuery.of(context).size.height/5,
									color: primaryMain,
									child: Row(
										crossAxisAlignment: CrossAxisAlignment.center,
										mainAxisSize: MainAxisSize.max,
										mainAxisAlignment: MainAxisAlignment.start,
										children: <Widget>[
											SizedBox(width: 30,),
											CircleAvatar(
												child: Image.asset('assets/images/avataaars.png'),
												radius: 50,
											),
											SizedBox(width: 30,),
											Column(
												mainAxisAlignment: MainAxisAlignment.center,
												children: <Widget>[
													Text(
														Activeuser.Name,
														style: TextStyle(
															fontSize: 25,
															fontWeight: FontWeight.w700,
															color: secondaryMain
														),
													),
													Text(
														'Coins: 0',
														style: TextStyle(
															fontSize: 20,
															fontWeight: FontWeight.w300,
															color: secondarySec
														),
													)
												],
											)
										],
									),
								),
								FlatButton(
									child: Text('Signout'),
									onPressed: () => FirebaseAuth.instance.signOut()
										.then((value) => Navigator.of(context).pushReplacement(new MaterialPageRoute(
										builder: (_) => Login()
									))),
								)
							],
						),
					),
				),
			),
		),
		body: PageView(
			controller: _controller,
			onPageChanged: (index) {
				setState(() {
				  num = index;
				});
			},
			children: <Widget>[
				HOme(),
				Center(
					child: Text(
						'Page2',
						style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
					),
				),
				Center(
					child: Text(
						'Page3',
						style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
					),
				)
			],
		),
		extendBody: true,
		bottomNavigationBar: FloatingNavbar(
			onTap: (int val) {
				_controller.animateToPage(val, duration: Duration(milliseconds: 250), curve: Curves.easeIn);
				setState(() {
				  num = val;
				});
			},
			currentIndex: num,
			items: [
				FloatingNavbarItem(icon: Icons.home, title: 'Home'),
				FloatingNavbarItem(icon: FlutterIcons.all_inclusive_mco, title: 'Categories'),
				FloatingNavbarItem(icon: FlutterIcons.profile_ant, title: 'Profile'),
			],
			backgroundColor: secondaryMain,
			selectedItemColor: primaryMain,
			selectedBackgroundColor: Colors.grey.shade200,
			unselectedItemColor: secondarySec,
		),
	);
  }
}


class _DrawerClipper extends CustomClipper<Path> {
	@override
	Path getClip(Size size) {
		Path path = Path();

		path.moveTo(size.width - 50, 0);
		path.quadraticBezierTo(size.width, size.height / 2, size.width  - 50, size.height);
		path.lineTo(0, size.height);
		path.lineTo(0, 0);
		return path;
	}

	@override
	bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}