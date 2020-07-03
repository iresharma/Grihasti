import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/views/Screens/Poducts/productPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

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

	bool cart;
	double _defaultValue;

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    cart = false;
	_defaultValue = 1;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
		child: Card(
			elevation: 1,
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(10),
			),
			child: Container(
				height: 250,
				width: 180,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
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
						),
						Padding(
							padding: EdgeInsets.all(6),
							child: cart ? StepperSwipe(
								initialValue:1,
								speedTransitionLimitCount: 3, //Trigger count for fast counting
								onChanged: (int value) => print('new value $value'),
								firstIncrementDuration: Duration(milliseconds: 250), //Unit time before fast counting
								secondIncrementDuration: Duration(milliseconds: 100), //Unit time during fast counting
								direction: Axis.horizontal,
								dragButtonColor: primaryMain,
								withNaturalNumbers: false,
								iconsColor: Colors.black38,
								withPlusMinus: true,
							) : FlatButton(
								onPressed: () {
									setState(() {
									  cart = true;
									});
								},
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: <Widget>[
									 	Icon(FlutterIcons.cart_plus_mco),
										Text('Add to cart')
									],
								),
								color: Colors.greenAccent,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(10)
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
