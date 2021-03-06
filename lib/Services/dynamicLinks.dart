import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

Future handleDynamicLink() async {

	PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();

	await _handleDeepLink(data);

	//handle reappearing app through deep link
	FirebaseDynamicLinks.instance.onLink(
		onSuccess: (PendingDynamicLinkData data) async {
			await _handleDeepLink(data);
		},
		onError: (OnLinkErrorException e) async {
			print('Error $e');
		}
	);

}

Future<void> _handleDeepLink(data) async {
	final Uri deeplink = data?.link;
//	if(deeplink != null) {
//		print(RegExp('https:\/\/grihasti.com\/forgot\/').hasMatch(deeplink.toString()));
//		if(RegExp('https:\/\/grihasti.com\/forgot\/').hasMatch(deeplink.toString())) {
//			landing = ForgotPass(deeplink.toString().split('/')[4]);
//		}
//	}
}