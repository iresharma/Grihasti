import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Products.dart';

void topProducts() async {
	print('====================Called==================');
	List<DocumentSnapshot> stream = await Firestore.instance.collection('product').getDocuments().then((value) => value.documents);
	Top = [];
	stream.forEach((element) {
		Top.add(
			Products(
				element.documentID,
				element.data['Name'],
				element.data['Desc'],
				element.data['Price'],
				element.data['Pic'],
				element.data['hash'] ?? '|HFFaXYk^6#M9wKSW@j=#*@-5c,1J5O[V=Nfs;w[@[or[k6.O[TLtJnNnO};FxngOZE3NgNHsps,jMFeS#OtcXnzRjxZxHj]OYNeR:JCs9xunhwIbeIpNaxHNGr;v}aeo0Xmt6XS\$et6#*\$ft6nhxHnNV@w{nOenwfNHo0'
			)
		);
	});
}