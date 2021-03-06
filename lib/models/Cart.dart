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
	final String category;
	final String variety;
	final List<dynamic> pictures;

	ProductCart(this.id, this.Name, this.desc, this.price, this.Pic, this.hash, this.count, this.category, this.variety, this.pictures);
}

class CartItem extends ChangeNotifier {

	List<ProductCart> cartItem = [];

	void removeFromCart(ProductCart prod) {
		bool removed = false;
		cartItem.forEach((element) {
			if(element.id == prod.id && element.variety == prod.variety) {
				element.count--;
				if(element.count == 0) {
					removed = true;
				}
			}
		});
		if(removed) {
			cartItem.removeWhere((element) => element.id == prod.id && element.variety == prod.variety);
		}
		notifyListeners();
	}

	void addToCart(ProductCart adds) {
		bool added = false;
		cartItem.forEach((element) {
			if(adds.id == element.id && element.variety == adds.variety) {
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
					adds.count ?? 1,
					adds.category,
					adds.variety,
					adds.pictures
				)
			);
		}
		notifyListeners();
	}

	int get len => cartItem.length;

	int get totalPrice {
		int price = 0;
		cartItem.forEach((element) {
			price = price + element.count * element.price;
		});
		return price;
	}

	void empty() {
		cartItem = [];
		notifyListeners();
	}

	List<Map<String, dynamic>> get process {
		List<Map<String, dynamic>> temp = [];
		cartItem.forEach((element) {
			temp.add({
				'id': element.id,
				'Name': element.Name,
				'desc': element.desc,
				'price': element.price,
				'Pic': element.Pic,
				'hash': element.hash,
				'count': element.count,
				'category': element.category,
				'variety': element.variety
			});
		});
		return temp;
	}

	void deProcess(List<dynamic> fireCart) {
		fireCart.forEach((element) {
			cartItem.add(ProductCart(
				element['id'],
				element['Name'],
				element['desc'],
				element['price'],
				element['Pic'],
				element['hash'],
				element['count'],
				element['category'],
				element['variety'],
				element['pictures']
			));
		});
		notifyListeners();
	}

	int count(String id, String variety) {
		bool z = true;
		int k;
		cartItem.forEach((element) {
			if(element.id == id && element.variety == variety) {
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