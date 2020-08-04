import 'package:flutter/material.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customerappgrihasti/views/Login.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class viewOrder extends StatelessWidget {

	final Order order;

	viewOrder({this.order});


	DateTime processTime(String arg) {
		int time = int.parse(arg);
		DateTime order = new DateTime.fromMicrosecondsSinceEpoch(time);
		return order;
	}

	@override
	Widget build(BuildContext context) {
		List<TimelineModel> items = [
			TimelineModel(Container(
				height: 100,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'Order placed',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(15),
								fontWeight: FontWeight.bold
							),
						),
						Text(
							'was place about ${timeago.format(processTime(order.ordered_on))}',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(10),
								fontWeight: FontWeight.w200
							),
						)
					],
				),
			),
				position: TimelineItemPosition.right,
				iconBackground: Colors.blue,
				icon: Icon(FlutterIcons.package_fea, color: Colors.white,)),
			TimelineModel(Container(
				height: 100,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'Order accepted',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(15),
								fontWeight: FontWeight.bold
							),
						),
						Text(
							'was accepted about ',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(10),
								fontWeight: FontWeight.w200
							),
						)
					],
				),
			),
				position: TimelineItemPosition.left,
				iconBackground: Colors.green,
				icon: Icon(FlutterIcons.truck_delivery_mco, color: Colors.white,)),
			TimelineModel(Container(
				height: 100,
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'Order delivered',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(15),
								fontWeight: FontWeight.bold
							),
						),
						Text(
							'was delivered about ',
							style: TextStyle(
								fontSize: ScreenUtil().setSp(10),
								fontWeight: FontWeight.w200
							),
						)
					],
				),
			),
				position: TimelineItemPosition.left,
				iconBackground: Colors.redAccent,
				icon: Icon(FlutterIcons.check_box_mdi, color: Colors.white,)),
		];

		return Scaffold(
			backgroundColor: Colors.white,
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
			body: SingleChildScrollView(
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: <Widget>[
						Container(
							height: ScreenUtil().setSp(100),
							padding: EdgeInsets.all(10),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisAlignment: MainAxisAlignment.spaceEvenly,
								children: <Widget>[
									RichText(
										text: TextSpan(
											children: <TextSpan>[
												TextSpan(
													text: 'Order #',
													style: TextStyle(
														fontWeight: FontWeight.bold,
														fontSize: ScreenUtil().setSp(20),
														color: Colors.black
													),
												),
												TextSpan(
													text: '${order.id}',
													style: TextStyle(
														fontWeight: FontWeight.w400,
														fontSize: ScreenUtil().setSp(15),
														color: Colors.black
													),
												)
											]
										),
									),
									Divider(thickness: 2, height: 16,),
									RichText(
										text: TextSpan(
											children: <TextSpan>[
												TextSpan(
													text: 'Number of items: ${order.items.length.toString()}',
													style: TextStyle(
														color: Colors.black,
														fontSize: ScreenUtil().setSp(10)
													)
												)
											]
										),
									),
									RichText(
										text: TextSpan(
											children: <TextSpan>[
												TextSpan(
													text: 'Payment mode: ${order.paymentId == 'COD' ? 'COD' : 'Online (' + order.paymentId + ')'}',
													style: TextStyle(
														color: Colors.black,
														fontSize: ScreenUtil().setSp(10)
													)
												)
											]
										),
									),
									RichText(
										text: TextSpan(
											children: <TextSpan>[
												TextSpan(
													text: 'Amount: ${order.price}',
													style: TextStyle(
														color: Colors.black,
														fontSize: ScreenUtil().setSp(10)
													)
												)
											]
										),
									),
								],
							)
						),
						Container(
							height: MediaQuery.of(context).size.height/3,
							padding: EdgeInsets.only(
								left: 25
							),
							child: Timeline(children: items, position: TimelinePosition.Left,),
						),
						Container(
							color: Colors.grey.shade200,
							padding: EdgeInsets.only(
								top: 10
							),
							height: 180.0 * (order.items.length + 1),
							child: ListView.builder(
								physics: NeverScrollableScrollPhysics(),
								itemCount: order.items.length + 2,
								itemBuilder: (context, index) {
									if(index == order.items.length + 1) return Container(
										padding: EdgeInsets.all(15),
										child: RaisedButton(
											child: Text('Order Again', style: TextStyle(color: Colors.white),),
											onPressed: () => print('order again'),
											color: Colors.deepOrangeAccent
										),
									);
									else if(index == 0) return Container(
										child: RichText(
											textAlign: TextAlign.center,
											text: TextSpan(
												children: <TextSpan>[
													TextSpan(
														text: '${order.items.length} item(s) ordered, for ',
														style: TextStyle(
															fontSize: ScreenUtil().setSp(10),
															fontWeight: FontWeight.w400,
															color: Colors.black
														)
													),
													TextSpan(
														text: '₹${order.price}',
														style: TextStyle(
															fontSize: ScreenUtil().setSp(10),
															fontWeight: FontWeight.w800,
															color: Colors.black
														)
													)
												]
											),
										),
									);
									return Container(
										color: Colors.white,
										height: 180,
										margin: EdgeInsets.only(
											top: 10
										),
										padding: EdgeInsets.all(10),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Text(
													'${order.items[index - 1].Name}',
													style: TextStyle(
														fontSize: ScreenUtil().setSp(20),
														fontWeight: FontWeight.w600
													),
												),
												Divider(),
												Row(
													mainAxisAlignment: MainAxisAlignment.spaceBetween,
													children: <Widget>[
														Text('Category: ${order.items[index-1].category}'),
														Container(
															child: Row(
																children: <Widget>[
																	Text('Price			'),
																	RawChip(
																		backgroundColor: Colors.green,
																		label: Text('₹${order.items[index - 1].price}'),
																		checkmarkColor: Colors.green,
																	)
																],
															),
														)
													],
												),
												Row(
													mainAxisAlignment: MainAxisAlignment.spaceBetween,
													children: <Widget>[
														Text('Count: ${order.items[index-1].count}'),
														Container(
															child: Row(
																children: <Widget>[
																	Text('Variety			'),
																	RawChip(
																		backgroundColor: Colors.yellowAccent,
																		label: Text('${order.items[index - 1].variety}'),
																		checkmarkColor: Colors.green,
																	)
																],
															),
														)
													],
												)
											],
										),
									);
								}
							),
						)
					],
				),
			),
		);
	}
}
