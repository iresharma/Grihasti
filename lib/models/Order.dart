import 'package:customerappgrihasti/models/Cart.dart';

class Order {

	final String id;
	final String price;
	final List<ProductCart> items;
	final String paymentId;
	final String uid;

  Order(this.id, this.price, this.items, this.paymentId, this.uid);

}