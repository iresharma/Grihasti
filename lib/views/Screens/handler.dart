import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/views/Screens/Category/categoryList.dart';
import 'package:customerappgrihasti/views/Screens/Proflie/profile_page.dart';
import 'package:customerappgrihasti/views/Screens/Poducts/products.dart';
import 'package:customerappgrihasti/views/Screens/offers/offers.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

	GlobalKey<ScaffoldState> _sacffold = new GlobalKey<ScaffoldState>();
	bool isSearch;
	double widthAn;
	String title;
	bool isProfile;
	PageController _pageController = new PageController();
	int cart;

	var selectedIndex;
	 @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    isSearch = false;
    widthAn = 0;
    title = 'Home';
    isProfile = false;
    cart = 0;
  }

  @override
  Widget build(BuildContext context) {
	 	print('handler');
	 	print(User);
    return Scaffold(
		key: _sacffold,
		appBar: isProfile ? null : AppBar(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.only(
					bottomLeft: Radius.circular(10),
					bottomRight: Radius.circular(10)
				),
			),
			elevation: 10,
			title: Text('GRIHASTI'),
			actions: <Widget>[
				Padding(
					padding: EdgeInsets.only(right: 10),
					child: isSearch ? AnimatedContainer(
						duration: Duration(milliseconds: 250),
						width: widthAn,
						child: TextField(
							decoration: InputDecoration(
								hintText: 'Search ..',
								prefixIcon: Icon(FlutterIcons.search1_ant),
								focusColor: secondaryMain,
								fillColor: secondaryMain
							)
						),
					)
						: Row(
						children: <Widget>[
							IconButton(
								icon: Icon(
									FlutterIcons.search1_ant,
									color: Colors.white,
								),
								onPressed: () {
									setState(() {
										isSearch = true;
									});
									Future.delayed(Duration(milliseconds: 50), () {
										setState(() {
											widthAn = MediaQuery.of(context).size.width * 0.75;
										});
									});
								},
							),
							IconButton(
								icon: FlutterBadge(
									itemCount: cart,
									icon: Icon(
										FlutterIcons.cart_mco,
										color: Colors.white,
									),
									badgeColor: Colors.greenAccent,
									borderRadius: 20,
									badgeTextColor: primaryMain,
								),
								onPressed: () => print('Cart'),
							)
						],
					),
				)
			],
			leading: IconButton(
				icon: Icon(FlutterIcons.align_left_fea),
				onPressed: () => _sacffold.currentState.openDrawer(),
			),
		),
		drawer: Drawer(
			child: Center(
				child: Column(
					children: <Widget>[
						Text(User['Name']),
						Text(User['Email']),
						FlatButton(
							child: Text('Signout'),
							onPressed: () {
								storage.deleteAll();
								writeData({
									'logged': 'false',
								});
							},
						)
					],
				),
			),
		),
		body: Stack(
			fit: StackFit.expand,
			children: <Widget>[
				PageView(
					children: <Widget>[
						ProductPage(),
						Center(
							child: Container(
								child: Catlist(),
							),
						),
						Center(
							child: Offers(),
						),
						Center(
							child: ProfilePage(),
						)
					],
					controller: _pageController,
					onPageChanged: (index) {
						if(index == 0) {
							setState(() {
								isProfile = false;
							});
						}
						else if(index == 1) {
							setState(() {
								isProfile = false;
							});
						}
						else if(index == 2) {
							setState(() {
								isProfile = false;
							});
						}
						else if(index == 3) {
							setState(() {
								isProfile = true;
							});
						}
						setState(() {
						  selectedIndex = index;
						});
					},
				),
				isSearch ? GestureDetector(
					child: Container(
						color: Colors.transparent,
					),
					onTap: () {
						setState(() {
							widthAn = 0;
						});
						Future.delayed(Duration(milliseconds: 250), () {
							setState(() {
								isSearch = false;
							});
						});
					},
				) : Container()
			],
		),
		bottomNavigationBar: FFNavigationBar(
			theme: FFNavigationBarTheme(
				barBackgroundColor: Colors.white,
				selectedItemBorderColor: primaryMain,
				selectedItemBackgroundColor: primaryMain,
				selectedItemIconColor: secondarySec,
				selectedItemLabelColor: Colors.black,
			),
			onSelectTab: (index) {
				setState(() {
					selectedIndex = index;
				});
				_pageController.animateToPage(index, duration: Duration(milliseconds: 250), curve: Curves.linear);
			},
			selectedIndex: selectedIndex,
			items: [
				FFNavigationBarItem(
					iconData: FlutterIcons.home_outline_mco,
					label: 'Home',
				),
				FFNavigationBarItem(
					iconData: FlutterIcons.$500px_ent,
					label: 'Categories',
				),
				FFNavigationBarItem(
					iconData: FlutterIcons.local_offer_mdi,
					label: 'Offers',
				),
				FFNavigationBarItem(
					iconData: FlutterIcons.user_astronaut_faw5s,
					label: 'Profile',
				),
			],
		),
	);
  }
}

