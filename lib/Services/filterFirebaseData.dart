import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/User.dart';

void topProducts() async {
	print('====================Called==================');
	List<DocumentSnapshot> stream = await Firestore.instance.collection('products').orderBy('Nsold', descending: true).getDocuments().then((value) => value.documents);
	Top = [];

	List<int> prices = [];
	List<String> variety = [];
	stream.forEach((element) {
		element.data['variety'].forEach((variey) {
			prices.add(variey['price']);
			variety.add(variey['name']);
		});
		Top.add(
			Products(
				element.documentID,
				element.data['Name'],
				element.data['Desc'],
				prices,
				element.data['Pic'],
				element.data['Hash'] ?? '|HFFaXYk^6#M9wKSW@j=#*@-5c,1J5O[V=Nfs;w[@[or[k6.O[TLtJnNnO};FxngOZE3NgNHsps,jMFeS#OtcXnzRjxZxHj]OYNeR:JCs9xunhwIbeIpNaxHNGr;v}aeo0Xmt6XS\$et6#*\$ft6nhxHnNV@w{nOenwfNHo0',
				element.data['category'] ?? 'Personal Care',
				variety ?? ['1Kg', '2Kg', '5Kg', '10Kg']
			)
		);
	});
}

void order() async {
	await Firestore.instance.collection('orders').where('uid', isEqualTo: Activeuser.Uid).snapshots().listen((event) {
		orders = [];
		if(event.documents.length != 0) {
			event.documents.forEach((element) {
				orders.add(Order(
					element.documentID,
					element.data['price'].toString(),
					element.data['cart'],
					element.data['paymentId'] ?? 'COD',
					element.data['uid']
				));
			});
		}
	});
}