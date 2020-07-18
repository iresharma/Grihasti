import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class RPayOptions {
	final int amount;
	final String name;
	final String desc;
	final Map<String, String> prefill;

  RPayOptions(this.amount, this.name, this.desc, this.prefill);
}

Future<dynamic> doPayment(RPayOptions options, BuildContext context) async {

	var razorPay = new Razorpay();

	razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
		print('======================================================================');
		print(Provider.of<CartItem>(context).cartItem);
		var uid = Activeuser.Uid;
		await Firestore.instance.collection('orders').document().setData({
			'items': Provider.of<CartItem>(context).process,
			'paymentId': response.paymentId,
			'price': Provider.of<CartItem>(context).totalPrice,
			'uid': uid
		});
		await Firestore.instance.collection('users').document(uid).updateData({
			'Cart': []
		});
		Provider.of<CartItem>(context).empty();
		Navigator.of(context).pop();
	});

	razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) => print('Error ${response.code}'));

	razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) => print(response.walletName));

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
}