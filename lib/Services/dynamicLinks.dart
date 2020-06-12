import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../main.dart';

Future handleDynamicLink() async {

	//handle opening of app through deep link
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

void _handleDeepLink(data) async {
	final Uri deeplink = data?.link;
	if(deeplink != null) {
		print('link $deeplink');
		launch = 'through link';
	}
}