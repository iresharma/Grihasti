import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:customerappgrihasti/views/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {

	TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.white,
		appBar: PreferredSize(
			preferredSize: Size.fromHeight(80.0),
			child: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				flexibleSpace: SafeArea(
					child: Row(
						crossAxisAlignment: CrossAxisAlignment.start,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text(
								'G',
								style: TextStyle(
									color: Colors.black87,
									fontSize: MediaQuery.of(context).size.width * 0.15,
									fontWeight: FontWeight.w400,
									fontFamily: 'Calli2',
								)
							),
							Text(
								'rihasti',
								style: TextStyle(
									color: Colors.black87,
									fontSize: MediaQuery.of(context).size.width * 0.13,
									fontWeight: FontWeight.w400,
									fontFamily: 'Calli'
								)
							)
						],
					),
				),
				leading: IconButton(
					icon: Icon(FlutterIcons.back_ant), color: Colors.black,
					onPressed: () => Navigator.of(context).pop(),
				),
			),
		),
		body: Theme(
			data: ThemeData(
				canvasColor: Colors.white
			),
			child: FloatingSearchBar.builder(
				itemCount: Provider.of<Search>(context).len,
				pinned: true,
				onChanged: (value) => Provider.of<Search>(context).search(value),
				itemBuilder: (BuildContext context, int index) {
					return Text(
							Provider.of<Search>(context).searchResult[index].name
					);
				},
				decoration: InputDecoration(
					border: InputBorder.none,
					floatingLabelBehavior: FloatingLabelBehavior.never,
					labelText: 'Search...',
					fillColor: Colors.white,
				),
				controller: _controller,
				trailing: CircleAvatar(
					child: Icon(FlutterIcons.search1_ant, color: secondarySec,),
					backgroundColor: primaryMain,
					foregroundColor: Colors.transparent,
				),
				drawer: Drawer(
					child: SafeArea(
						child: ListView(
							children: <Widget>[
								Container(
									height: MediaQuery.of(context).size.height/5,
									color: primaryMain,
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.center,
										mainAxisSize: MainAxisSize.max,
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget>[
											CircleAvatar(
												child: Image.asset('assets/images/avataaars.png'),
												radius: 50,
											),
											SizedBox(height: 20,),
											Column(
												mainAxisAlignment: MainAxisAlignment.center,
												children: <Widget>[
													Text(
														Activeuser.Name ?? 'Name Sharma',
														style: TextStyle(
															fontSize: ScreenUtil().setSp(15),
															fontWeight: FontWeight.w700,
															color: secondaryMain
														),
													),
													Text(
														'Coins: ${Activeuser.coins}',
														style: TextStyle(
															fontSize: ScreenUtil().setSp(10),
															fontWeight: FontWeight.w300,
															color: secondarySec
														),
													)
												],
											)
										],
									),
								),
								Container(
									color: Colors.white,
									child: FlatButton(
										child: Text('Orders'),
										onPressed: () => Navigator.of(context).pushNamed('/orders'),
									),
								),
								Container(
									color: Colors.white,
									child: FlatButton(
										child: Text('Signout'),
										onPressed: () => FirebaseAuth.instance.signOut()
											.then((value) => Navigator.of(context).pushReplacement(new MaterialPageRoute(
											builder: (_) => Login()
										))),
									),
								)
							],
						),
					),
				),
				onTap: () {},
			),
		),
	);
  }
}
