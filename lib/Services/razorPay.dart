import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class RPayOptions {
	final int amount;
	final String name;
	final String desc;
	final Map<String, String> prefill;

  RPayOptions({this.amount, this.name, this.desc, this.prefill});
}

Future<dynamic> doPayment(RPayOptions options, BuildContext context, BuildContext context1, double coinVal, String place) async {

	var razorPay = new Razorpay();

	bool ret;

	var reponse = await http.post(
		'https://api.razorpay.com/v1/orders',
		headers: <String, String>{
			'authorization': 'Basic ${base64Encode(utf8.encode('rzp_test_wZHvxZO1Q3PwLK:q5Rl7HGVRDYt0YPlfVJmW9c6'))}',
			'content-type': 'application/json'
		},
		body: jsonEncode({
			'payment_capture': 1,
			'amount': options.amount,
			'currency': 'INR'
		})
	);

	var option = {
		'key': 'rzp_test_wZHvxZO1Q3PwLK',
		'amount': options.amount, //in the smallest currency sub-unit.
		'name': options.name,// Generate order_id using Orders API
		'description': options.desc,
		'prefill': options.prefill,
		'order_id': jsonDecode(reponse.body)['id']
	};

	razorPay.open(option);

	razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
		print('======================================================================');
		print(Provider.of<CartItem>(context).cartItem);
		var uid = Activeuser.Uid;
		await Firestore.instance.collection('orders').document().setData({
			'items': Provider.of<CartItem>(context).process,
			'paymentId': response.paymentId,
			'price': Provider.of<CartItem>(context).totalPrice,
			'uid': uid,
			'orderId': jsonDecode(reponse.body)['id'],
			'status': 'ordered',
			'ordered_on': DateTime.now().microsecondsSinceEpoch
		});

		Activeuser.coins = Activeuser.coins - coinVal.round();
		if(place == 'Cart') {
			await Firestore.instance.collection('users').document(uid).updateData({
				'Cart': [],
				'coins': Activeuser.coins
			});
			Provider.of<CartItem>(context).empty();
		} else {
			await Firestore.instance.collection('users').document(uid).updateData({
				'coins': Activeuser.coins
			});
		}
		Navigator.of(context).pop();
		Scaffold.of(context1).showSnackBar(SnackBar(
			content: Text(
				'Order Placed',
				style: TextStyle(
					fontSize: ScreenUtil().setSp(12)
				),
			),
			duration: Duration(seconds: 2),
			action: SnackBarAction(
				label: 'Check orders',
				onPressed: () => Navigator.of(context1).pushNamed('/orders'),
			),
		));
	});

	razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
		Navigator.of(context).pop();
		Scaffold.of(context1).showSnackBar(SnackBar(
			content: Text(
				'Order could not be placed, please try again later',
				style: TextStyle(
					fontSize: ScreenUtil().setSp(12),
					color: primaryMain
				),
			),
			duration: Duration(seconds: 2),
			action: SnackBarAction(
				label: 'Check orders',
				onPressed: () => Navigator.of(context1).pushNamed('/orders'),
			),
		));
	});

	razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) => print(response.walletName));
}