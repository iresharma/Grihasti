import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Category.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'dart:core';
void topProducts() async {
	print('====================${Activeuser.Uid}==================');
	List<DocumentSnapshot> stream = await Firestore.instance.collection('products').getDocuments().then((value) => value.documents);
	Top = [];

	List<int> prices = [];
	List<String> variety = [];
	stream.forEach((element) {
		element.data['Variety'].forEach((variey) {
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
				element.data['Hash'],
				element.data['Category']['name'],
				variety,
				element.data['Subcategory']['name']
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
		cat = [];
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