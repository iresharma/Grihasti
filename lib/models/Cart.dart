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

	void removeFromCart(Products prod) {
		bool removed = false;
		cartItem.forEach((element) {
			if(element.id == prod.id) {
				element.count--;
				if(element.count == 0) {
					removed = true;
				}
			}
		});
		if(removed) {
			cartItem.removeWhere((element) => element.id == prod.id);
		}
		notifyListeners();
	}

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
					1
				)
			);
		}
		notifyListeners();
	}

	int get len => cartItem.length;

	int count(String id) {
		bool z = true;
		int k;
		cartItem.forEach((element) {
			if(element.id == id) {
				z = false;
				k =  element.count;
			}
		});
		if(z) {
			return 0;
		}
		else {
			return k;
		}
	}
}