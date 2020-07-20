import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:customerappgrihasti/components/OrdersBox.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customerappgrihasti/views/Login.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.grey.shade200,
		appBar: PreferredSize(
			child: Builder(
				builder: (context) => AppBar(
					backgroundColor: Colors.transparent,
					leading: Hero(
						child: IconButton(
							icon: Icon(FlutterIcons.align_left_fea, color: Colors.black38,),
							onPressed: () => Scaffold.of(context).openDrawer(),
						),
						tag: 'Drawer',
					),
					elevation: 0,
					flexibleSpace: SafeArea(
						child: Hero(
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
							tag: 'Logo',
						),
					),
					actions: <Widget>[
						Hero(
							child: IconButton(
								icon: Icon(FlutterIcons.search1_ant,color: Colors.black38,),
								onPressed: () => print('hi'),
							),
							tag: 'Search',
						),
						Hero(
							child: IconButton(
								icon: FlutterBadge(
									itemCount: Provider.of<CartItem>(context).len,
									badgeColor: Colors.greenAccent,
									icon: Icon(FlutterIcons.cart_evi, size: 35, color: Colors.black38,),
									badgeTextColor: Colors.black38,
									contentPadding: EdgeInsets.all(7),
								),
								onPressed: () => Navigator.of(context).pushNamed('/cart'),
							),
							tag: 'Cart',
						)
					],
				),
			),
			preferredSize: Size.fromHeight(80.0)
		),
		drawer: Theme(
			data: ThemeData(
				canvasColor: Colors.white
			),
			child: Drawer(
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
													'Coins: 0',
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
		),
		body: Container(
			height: MediaQuery.of(context).size.height,
			child: orders.length == 0 ? SvgPicture.asset(
				'assets/svg/emptyOrder.svg',
				width: MediaQuery.of(context).size.height * 0.8,
			) : ListView.builder(
				itemCount: orders.length,
				itemBuilder: (context, index) {
					return Container(
						margin: EdgeInsets.only(
							top: 10,
							bottom: 0,
							left: 10,
							right: 10
						),
						child: OrdersBox(
							order: orders[index],
						),
					);
				},
			),
		),
	);
  }
}
