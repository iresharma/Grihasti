import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/secureStorage.dart';
import 'package:customerappgrihasti/views/Screens/Category/categoryList.dart';
import 'package:customerappgrihasti/views/Screens/Proflie/profile_page.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

	var selectedIndex;
	 @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    isSearch = false;
    widthAn = 0;
    title = 'Home';
    isProfile = false;
  }

  @override
  Widget build(BuildContext context) {
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
			actions: <Widget>[
				Padding(
					padding: EdgeInsets.only(right: 10),
					child: isSearch ? AnimatedContainer(
						duration: Duration(milliseconds: 250),
						width: widthAn,
						child: TextField(
							decoration: InputDecoration(
								hintText: 'Search ..',
								prefixIcon: Icon(FlutterIcons.search1_ant)
							)
						),
					)
						: Row(
						children: <Widget>[
							Text(
								title,
								style: TextStyle(
									fontSize: 25,
									fontWeight: FontWeight.w800
								),
							),
							IconButton(
								icon: Icon(FlutterIcons.search1_ant),
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
			child: Text('hello'),
		),
		body: Stack(
			fit: StackFit.expand,
			children: <Widget>[
				PageView(
					children: <Widget>[
						Center(
							child: FlatButton(
								child: Text(
									'1',
									style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
								),
								onPressed: () => writeData({
									'logged': "false"
								}),
							),
						),
						Center(
							child: Container(
								child: Catlist(),
							),
						),
						Center(
							child: FlatButton(
								child: Text(
									'3',
									style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
								),
								onPressed: () => writeData({
									'logged': 'false'
								}),
							),
						),
						Center(
							child: ProfilePage(),
						)
					],
					controller: _pageController,
					onPageChanged: (index) {
						if(index == 0) {
							setState(() {
								title = 'Products';
								isProfile = false;
							});
						}
						else if(index == 1) {
							setState(() {
								title = 'Category';
								isProfile = false;
							});
						}
						else if(index == 2) {
							setState(() {
								title = 'Offers';
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
					iconData: FlutterIcons.ios_menu_ion,
					label: 'Products',
				),
				FFNavigationBarItem(
					iconData: Icons.category,
					label: 'Category',
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

