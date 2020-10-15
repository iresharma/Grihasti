import 'package:customerappgrihasti/components/OrderItemBox.dart';
import 'package:customerappgrihasti/views/RefundPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter_screenutil/screenutil.dart';
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
								icon: Icon(FlutterIcons.ios_arrow_back_ion, color: Colors.black38,),
								onPressed: () => Navigator.of(context).pop(),
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
									Divider(thickness: 2, height: 10,),
									RichText(
										text: TextSpan(
											children: <TextSpan>[
												TextSpan(
													text: 'Number of items: ${order.items.length.toString()}',
													style: TextStyle(
														color: Colors.black,
														fontSize: ScreenUtil().setSp(13)
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
														fontSize: ScreenUtil().setSp(13)
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
														fontSize: ScreenUtil().setSp(13)
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
								itemCount: order.items.length + 3,
								itemBuilder: (context, index) {
									if(index == order.items.length + 1) return Container(
										padding: EdgeInsets.all(15),
										child: FlatButton.icon(
											icon: Icon(FlutterIcons.shopping_cart_fea, color: Colors.white),
											label: Text('Order Again', style: TextStyle(color: Colors.white),),
											shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(10)
											),
											onPressed: () {
												if(Provider.of<CartItem>(context).len == 0) {
													order.items.forEach((element) {
														Provider.of<CartItem>(context).addToCart(element);
													});
												} else return showDialog(
														context: context,
														builder: (context) {
															return AlertDialog(
																elevation: 10,
																title: Text(
																	'Cart already has items',
																	style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
																),
																content: Text(
																		'The already has ${Provider.of<CartItem>(context).len} item(s)'
																),
																actions: [
																	ButtonBar(
																		children: [
																			FlatButton(
																				child: Text(
																					'Empty',
																					style: TextStyle(
																							color: Colors.red
																					),
																				),
																				onPressed: () {
																					Provider.of<CartItem>(context).empty();
																					order.items.forEach((element) {
																						Provider.of<CartItem>(context).addToCart(element);
																					});
																					Navigator.of(context).pop();
																				},
																			),
																			FlatButton(
																				child: Text(
																					'Add',
																				),
																				onPressed: () {
																					order.items.forEach((element) {
																						Provider.of<CartItem>(context).addToCart(element);
																					});
																					Navigator.of(context).pop();
																				},
																			)
																		],
																	)
																],
															);
														}
												);
											},
											color: Colors.deepOrangeAccent
										),
									);
									else if(index == order.items.length + 2) return Container(
										padding: EdgeInsets.all(15),
										child: FlatButton.icon(
												icon: Icon(FlutterIcons.assignment_return_mdi, color: Colors.white,),
												label: Text('Return/Refund', style: TextStyle(color: Colors.white),),
												onPressed: () => Navigator.of(context).push(MaterialPageRoute(
													builder: (_) => RefunPage(
														order: order,
													)
												)),
												color: Colors.blueAccent,
												shape: RoundedRectangleBorder(
													borderRadius: BorderRadius.circular(10)
												),
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
									return OrderItemBox(
										product: order.items[index - 1],
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
