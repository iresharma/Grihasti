import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Products {

	final String id;
	final String Name;
	final String desc;
	final int price;
	final String Pic;
	final String hash;

  	Products(this.id, this.Name, this.desc, this.price, this.Pic, this.hash);
}

class ProductData extends ChangeNotifier {
	List<Products> show = [];

	void addProduct(QuerySnapshot q) {
		q.documents.forEach((data) {
			show.add(Products(
				data.documentID,
				data.data['Name'],
				data.data['Desc'],
				data.data['Price'],
				data.data['Pic'],
				data.data['Hash'] ?? ''
			));
		});
		notifyListeners();
	}
}