import 'package:flutter/foundation.dart';
import 'Products.dart';

class ProductCart {

	final String id;
	final String Name;
	final String desc;
	final int price;
	final String Pic;
	final String hash;
	int count;

	ProductCart(this.id, this.Name, this.desc, this.price, this.Pic, this.hash, this.count);
}



class CartItem extends ChangeNotifier {

	List<ProductCart> cartItem = [];

	void addToCart(Products adds) {
		bool added = false;
		cartItem.forEach((element) {
			if(adds.id == element.id) {
				element.count++;
				added = true;
			}
		});
		if(!added) {
			cartItem.add(
				ProductCart(
					adds.id,
					adds.Name,
					adds.desc,
					adds.price,
					adds.Pic,
					adds.hash,
					0
				)
			);
		}
		notifyListeners();
	}

	int get len => cartItem.length;

	int count(String id) => cartItem.where((element) => element.id == id).toList()[0].count;
}