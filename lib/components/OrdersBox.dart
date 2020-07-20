import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersBox extends StatelessWidget {

	final Order order;

	OrdersBox({this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
		child: Container(
			width: MediaQuery.of(context).size.width,
			height: MediaQuery.of(context).size.height/5,
			decoration: BoxDecoration(
				color: Colors.white,
			),
			padding: EdgeInsets.all(10),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
					RichText(
						text: TextSpan(
							children: [
								TextSpan(
									text: 'Order Id: ',
									style: TextStyle(
										fontWeight: FontWeight.w400,
										fontSize: ScreenUtil().setSp(15),
										color: Colors.black
									)
								),
								TextSpan(
									text: order.id,
									style: TextStyle(
										fontWeight: FontWeight.w300,
										fontSize: ScreenUtil().setSp(12),
										color: Colors.black
									)
								)
							]
						),
					),
					Divider(thickness: 2,),
					Padding(
						padding: EdgeInsets.only(
							left: 20
						),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
								Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
										Row(
											children: <Widget>[
												Text(
													'Status: ',
													style: TextStyle(
														fontWeight: FontWeight.w500,
														fontSize: ScreenUtil().setSp(15),
														color: Colors.black
													),
												),
												Container(
													decoration: BoxDecoration(
														color: Colors.green,
														borderRadius: BorderRadius.circular(1000)
													),
													margin: EdgeInsets.only(left: 10),
													padding: EdgeInsets.all(5),
													child: Text(
														order.status,
														style: TextStyle(
															fontWeight: FontWeight.w300,
															fontSize: ScreenUtil().setSp(13),
															color: Colors.white
														),
													),
												),
											],
										),
										RichText(
											text: TextSpan(
												children: [
													TextSpan(
														text: 'Ordered on:   ',
														style: TextStyle(
															fontWeight: FontWeight.w500,
															fontSize: ScreenUtil().setSp(13),
															color: Colors.black
														)
													),
													TextSpan(
														text: order.ordered_on,
														style: TextStyle(
															fontWeight: FontWeight.w300,
															fontSize: ScreenUtil().setSp(13),
															color: Colors.black
														)
													)
												]
											),
										),
									],
								),
								SizedBox(height: MediaQuery.of(context).size.height * 0.015,),
								if(order.paymentId == 'COD')...{
									RichText(
										text: TextSpan(
											children: [
												TextSpan(
													text: 'Payment mode:   ',
													style: TextStyle(
														fontWeight: FontWeight.w500,
														fontSize: ScreenUtil().setSp(13),
														color: Colors.black
													)
												),
												TextSpan(
													text: 'Offline',
													style: TextStyle(
														fontWeight: FontWeight.w300,
														fontSize: ScreenUtil().setSp(12),
														color: Colors.black
													)
												)
											]
										),
									)
								}
								else...{
									Row(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Text(
												'Payment mode:   ',
												style: TextStyle(
													fontWeight: FontWeight.w500,
													fontSize: ScreenUtil().setSp(15),
													color: Colors.black
												)
											),
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												mainAxisAlignment: MainAxisAlignment.end,
												children: <Widget>[
													Text(
														'Online',
														style: TextStyle(
															fontWeight: FontWeight.w300,
															fontSize: ScreenUtil().setSp(15),
															color: Colors.black
														)
													),
													Text(
														'(${order.paymentId})',
														style: TextStyle(
															fontWeight: FontWeight.w300,
															fontSize: ScreenUtil().setSp(7),
															color: Colors.black
														)
													),
												],
											)
										],
									)
								},
								SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
								RichText(
									text: TextSpan(
										children: [
											TextSpan(
												text: 'Amount:   ',
												style: TextStyle(
													fontWeight: FontWeight.w500,
													fontSize: ScreenUtil().setSp(13),
													color: Colors.black
												)
											),
											TextSpan(
												text: '₹${order.price}',
												style: TextStyle(
													fontWeight: FontWeight.w300,
													fontSize: ScreenUtil().setSp(13),
													color: Colors.black
												)
											)
										]
									),
								),
							],
						),
					)
				],
			),
		),
	);
  }
}
