import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/views/Screens/Poducts/productPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSquareBox extends StatefulWidget {

	final String Name;
	final String desc;
	final int price;
	final String productId;

  const ProductSquareBox({Key key, this.productId, this.desc, this.price, this.Name}) : super(key: key);


  @override
  _ProductSquareBoxState createState() => _ProductSquareBoxState();
}

class _ProductSquareBoxState extends State<ProductSquareBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
		child: Card(
			child: Container(
				height: 180,
				width: 180,
				child: Column(
					children: <Widget>[
						SizedBox(
							height: 100,
							width: 180,
							child: FutureBuilder(
								future: Firestore.instance.collection('product').document(widget.productId.toString()).get(),
								builder: (context, snapshot) {
									if(!snapshot.hasData) {
										return Center(
											child: CircularProgressIndicator(),
										);
									}
									else {
										return Image.network(
											snapshot.data.data['Pic'],
											height: 100,
											width: 100,
										);
									}
								},
							),
						),
						Align(
							alignment: Alignment.centerLeft,
							child: Column(
								mainAxisAlignment: MainAxisAlignment.start,
								crossAxisAlignment: CrossAxisAlignment.start,
								children: <Widget>[
									Text(
										widget.Name,
										overflow: TextOverflow.ellipsis,
										style: TextStyle(
											fontWeight: FontWeight.w600,
											fontSize: 15
										),
									),
									Text(
										widget.desc,
										overflow: TextOverflow.ellipsis,
										style: TextStyle(
											fontSize: 15,
											fontWeight: FontWeight.w300
										),
									)
								],
							),
						),
						Align(
							alignment: Alignment.centerRight,
							child: Container(
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(10),
									color: Colors.lightGreen,
								),
								padding: EdgeInsets.all(5),
								child: Text(
									'₹${widget.price.toString()}',
									style: TextStyle(
										color: Colors.white,
										fontWeight: FontWeight.w700,
										fontSize: 15
									),
								),
							),
						)
					],
				),
			),
		),
		onTap: () => Navigator.of(context).push(
			new MaterialPageRoute(
				builder: (_) => ProductPAge(
					productId: widget.productId,
					name: widget.Name,
				)
			)
		),
	);
  }
}
