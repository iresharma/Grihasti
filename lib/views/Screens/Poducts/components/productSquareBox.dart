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
	int current;
	int count;

	@override
	void initState() {
		// TODO: implement initState
		super.initState();
		cart = false;
		_defaultValue = 1;
		current = 0;
		count = 1;
		cartItem.forEach((re) => {
			if(re['id'] == widget.productId) {
				count++
			}
		});
	}

	void setter(){
		for(int i = 0; i < cartItem.length-1; i++) {
			var check = cartItem[i];
			for(int j = i+1; j < cartItem.length; j++) {
				if (check['id'] == cartItem[j]['id']) {
					setState(() {
						check['count']++;
						cartItem.removeAt(j);
					});
				}
			}
		}
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
							child: cart ? Container(
								child: Row(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
									children: <Widget>[
										IconButton(
											icon: Icon(FlutterIcons.plus_fea),
											splashColor: primaryMain,
											color: secondarySec,
											onPressed: () {
												setState(() {
													count = 0;
													cartItem.add({
														'Name': widget.Name,
														'Price': widget.price.toString(),
														'id': widget.productId,
														'count': 1
													});
													setter();
													cartItem.forEach((re) => {
														if(re['id'] == widget.productId) {
															count = re['count']
														}
													});
												});
											},
										),
										Text(count.toString()),
										IconButton(
											icon: Icon(FlutterIcons.minus_fea),
											splashColor: primaryMain,
											color: secondarySec,
											focusColor: primaryMain,
											onPressed: () {
												setState(() {
													for(int i = 0; i < cartItem.length; i++) {
														if(cartItem[i]['id'] == widget.productId) {
															cartItem[i]['count']--;
															if(cartItem[i]['count'] == 0) {
																cartItem.removeAt(i);
															}
															break;
														}
													}
													count--;
													if(count == 0) {
														setState(() {
														  cart = false;
														});
													}
												});
											},
										),
									],
								),
							) : FlatButton(
								onPressed: () {
									setState(() {
									  cart = true;
									  cartItem.add({
										  'Name': widget.Name,
										  'Price': widget.price.toString(),
										  'id': widget.productId,
										  'count': 1
									  });
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
