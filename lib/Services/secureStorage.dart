import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/views/app.dart';
import 'package:customerappgrihasti/views/introScroll.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

Future<Null> loadData() async {
	User = await storage.readAll();
	landing = User['logged'] == "false" || User['logged'] == null ? IntroScroller() : App();
	print(User);
}

Future<Null> writeData(Map<String, String> data) async {
	data.forEach((key, values) async => await storage.write(key: key, value: values));
}