import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Category.dart';
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

List<ProductCart> processOrders(List<dynamic> items) {
	List<ProductCart> temp = [];
	items.forEach((adds) {
		temp.add(ProductCart(
			adds['id'],
			adds['Name'],
			adds['desc'],
			adds['price'],
			adds['Pic'],
			adds['hash'],
			adds['count'],
			adds['category'],
			adds['variety']
		));
	});
	return temp;
}

void order() {
	Firestore.instance.collection('orders').where('uid', isEqualTo: Activeuser.Uid).snapshots().listen((event) {
		orders = [];
		if(event.documents.length != 0) {
			event.documents.forEach((element) {
				orders.add(Order(
					element.documentID,
					element.data['price'].toString(),
					processOrders(element.data['items']),
					element.data['paymentId'] ?? 'COD',
					element.data['uid']
				));
			});
		}
	});
}

List<Map<String, String>> processSubCategory(List<dynamic> hi) {
	List<Map<String, String>> temp = [];
	hi.forEach((element) {
		temp.add({
			'name': element['name'],
			'id': element['id'],
		});
	});
}

void category() {
	Firestore.instance.collection('categories').getDocuments().then((value) {
		value.documents.forEach((element) {
			cat.add(Category(
				element.data['name'],
				element.data['id'],
				processSubCategory(element.data['subCategories']),
				element.data['icon'] ?? 'https://firebasestorage.googleapis.com/v0/b/grihasti-nirmal.appspot.com/o/personal-care.svg?alt=media&token=0798fc78-14d4-40f0-8673-f5e5e504fd06'
			));
		});
	});
}