import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {

	final ProductCart product;

  const CartProduct({Key key, this.product}) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
		width: MediaQuery.of(context).size.width,
		height: MediaQuery.of(context).size.height/6 - 10,
		margin: EdgeInsets.all(5),
		padding: EdgeInsets.all(10),
		decoration: BoxDecoration(
			borderRadius: BorderRadius.circular(10),
			color: Colors.white
		),
		child: Row(
			children: <Widget>[
				SizedBox(
					width: MediaQuery.of(context).size.width/4,
					height: MediaQuery.of(context).size.height/6 - 40,
					child: BlurHash(
						image: widget.product.Pic,
						hash: 'qEHV6nWB2yk8\$NxujFNGpyo0adR*=ss:I[R%.7kCMdnjx]S2NHs:S#M|%1%2ENRis9aiSis.slNHW:WBxZ%2ogaekBW;ofo0NHS4',
					),
				),
				SizedBox(width: 30,),
				Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						SizedBox(height: 10,),
						Text(
							widget.product.Name,
							style: TextStyle(
								fontSize: 25,
								fontWeight: FontWeight.w800
							),
						),
						SizedBox(height: 10,),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Text(
											'Category',
											style: TextStyle(
												fontWeight: FontWeight.w200,
												fontSize: 15
											),
										),
										Text(
											widget.product.category,
											style: TextStyle(
												fontWeight: FontWeight.w400,
												fontSize: 20
											),
										)
									],
								),
								SizedBox(width: 50,),
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Text(
											'Varient',
											style: TextStyle(
												fontWeight: FontWeight.w200,
												fontSize: 15
											),
										),
										Text(
											'${widget.product.variety}',
											style: TextStyle(
												fontWeight: FontWeight.w400,
												fontSize: 20
											),
										),
									],
								)
							],
						),
						SizedBox(height: 10,),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Container(
									width: 120,
									child: Text(
										'₹${widget.product.price}',
										style: TextStyle(
											color: primaryMain,
											fontWeight: FontWeight.w900,
											fontSize: 35
										),
									),
									color: Colors.white,
								),
								SizedBox(width: 40,),
								Container(
									decoration: BoxDecoration(
										color: primaryMain,
										borderRadius: BorderRadius.circular(100)
									),
									height: 40,
									child: Row(
										children: <Widget>[
											SizedBox(width: 5,),
											Container(
												height: 32,
												width: 32,
												padding: EdgeInsets.all(0),
												child: MaterialButton(
													shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
													child: Text(
														'-',
														style: TextStyle(
															color: primaryMain,
															fontSize: 32,
															fontWeight: FontWeight.w300
														),
														textAlign: TextAlign.center,
													),
													color: Colors.white,
													textColor: Colors.red,
													onPressed: () => Provider.of<CartItem>(context).removeFromCart(ProductCart(
														widget.product.id,
														widget.product.Name,
														widget.product.desc,
														widget.product.price,
														widget.product.Pic,
														widget.product.hash,
														0,
														widget.product.category,
														widget.product.variety
													)),
												),
											),
											Padding(
												padding: EdgeInsets.all(10),
												child: Text(
													Provider.of<CartItem>(context).count(widget.product.id, widget.product.variety).toString(),
													style: TextStyle(
														color: Colors.white,
														fontWeight: FontWeight.w700,
														fontSize: 20
													),
												),
											),
											Container(
												height: 32,
												width: 32,
												padding: EdgeInsets.all(0),
												child: MaterialButton(
													shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
													child: Text(
														'+',
														style: TextStyle(
															color: primaryMain,
															fontSize: 32,
															fontWeight: FontWeight.w300
														),
														textAlign: TextAlign.center,
													),
													color: Colors.white,
													textColor: Colors.red,
													onPressed: () => Provider.of<CartItem>(context).addToCart(ProductCart(
														widget.product.id,
														widget.product.Name,
														widget.product.desc,
														widget.product.price,
														widget.product.Pic,
														widget.product.hash,
														0,
														widget.product.category,
														widget.product.variety
													)),
												),
											),
											SizedBox(width: 5,)
										],
									),
								)
							],
						)
					],
				)
			],
		),
	);
  }
}
