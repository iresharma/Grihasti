import 'package:customerappgrihasti/models/Cart.dart';

class Order {

	final String id;
	final String price;
	final List<ProductCart> items;
	final String paymentId;
	final String uid;
	final String status;
	final String ordered_on;
	final double discount;

  Order(this.id, this.price, this.items, this.paymentId, this.uid, this.ordered_on, this.status, this.discount);

}