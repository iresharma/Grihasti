import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSquareBox extends StatefulWidget {

	final String productId;

  const ProductSquareBox({Key key, this.productId}) : super(key: key);

  @override
  _ProductSquareBoxState createState() => _ProductSquareBoxState();
}

class _ProductSquareBoxState extends State<ProductSquareBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
		child: Container(
			height: 180,
			width: 180,
			child: Column(
				children: <Widget>[
					SizedBox(
						height: 100,
						width: 180,
						child: Placeholder(),
					),
					Align(
						alignment: Alignment.centerLeft,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.start,
							crossAxisAlignment: CrossAxisAlignment.start,
							children: <Widget>[
								Text(
									'Product Name',
									overflow: TextOverflow.ellipsis,
									style: TextStyle(
										fontWeight: FontWeight.w600,
										fontSize: 15
									),
								),
								Text(
									'Small desc.',
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
								'₹345',
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
	);
  }
}
