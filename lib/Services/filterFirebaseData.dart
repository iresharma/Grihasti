import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Products.dart';

void topProducts() async {
	List<DocumentSnapshot> stream = await Firestore.instance.collection('product').getDocuments().then((value) => value.documents);
	stream.forEach((element) {
		Top.add(
			Products(
				element.documentID,
				element.data['Name'],
				element.data['Desc'],
				element.data['Price'],
				element.data['Pic'],
				element.data['hash'] ?? ''
			)
		);
	});
}