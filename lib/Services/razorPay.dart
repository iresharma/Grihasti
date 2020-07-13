import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RPayOptions {
	final int amount;
	final String name;
	final String desc;
	final Map<String, String> prefill;

  RPayOptions(this.amount, this.name, this.desc, this.prefill);
}

Future<dynamic> doPayment(RPayOptions options, BuildContext context) {

	var razorPay = new Razorpay();

	razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) {
		print('======================================================================');
		print(Provider.of<CartItem>(context).cartItem);
		Provider.of<CartItem>(context).empty();
	});

	razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) => print('Error ${response.code}'));

	razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, (ExternalWalletResponse response) => print(response.walletName));

	var option = {
		'key': 'rzp_test_wZHvxZO1Q3PwLK',
		'amount': options.amount, //in the smallest currency sub-unit.
		'name': options.name,// Generate order_id using Orders API
		'description': options.desc,
		'prefill': options.prefill
	};

	razorPay.open(option);
}