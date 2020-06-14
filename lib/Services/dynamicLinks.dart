import 'package:customerappgrihasti/views/user/forgotPass.dart';
import 'package:customerappgrihasti/views/user/login.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Future handleDynamicLink() async {

	PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

	_handleDeepLink(data);

	//handle reappearing app through deep link
	FirebaseDynamicLinks.instance.onLink(
		onSuccess: (PendingDynamicLinkData data) async {
			_handleDeepLink(data);
		},
		onError: (OnLinkErrorException e) async {
			print('Error $e');
		}
	);

}

Future<Route> _handleDeepLink(data) async {
	final Uri deeplink = data?.link;
	if(deeplink != null) {
		print('link $deeplink');
		if(RegExp('https:\/\/grihasti.com\/forgot\/').hasMatch(deeplink.toString())) {
			return new MaterialPageRoute(builder: (_) => ForgotPass(deeplink.toString().split('/')[4]));
		}
	}
}