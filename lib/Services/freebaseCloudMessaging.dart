import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging FCM = FirebaseMessaging();

var Noti = '';

void initFCM() async {
	FCM.configure(
		onMessage: (Map<String, dynamic> message) async{
			print(message);
		},
		onLaunch: (Map<String, dynamic> message) async{
			print(message);
		},
		onResume: (Map<String, dynamic> message) async{
			print(message);
		},
	);
	FCM.requestNotificationPermissions(
		const IosNotificationSettings(
			sound: true,
			badge: true,
			alert: true,
			provisional: true,
		),
	);
	FCM.onIosSettingsRegistered.listen((IosNotificationSettings settings) {});
	FCM.getToken().then((token) => Noti = token);
	FCM.subscribeToTopic('hello');
}