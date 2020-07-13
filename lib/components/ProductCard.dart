import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {

	final Products product;

	const ProductCard({Key key, this.product}) : super(key: key);

	@override
	_ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

	int dropDownValue;

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
		width: MediaQuery.of(context).size.width,
		height: MediaQuery.of(context).size.height/5 - 10,
		margin: EdgeInsets.all(5),
		padding: EdgeInsets.all(10),
		decoration: BoxDecoration(
			borderRadius: BorderRadius.circular(10),
			color: Colors.white
		),
		child: Row(
			children: <Widget>[
				SizedBox(
					width: MediaQuery.of(context).size.width/3,
					height: MediaQuery.of(context).size.height/5 - 40,
					child: BlurHash(
						image: widget.product.Pic,
						hash: 'qEHV6nWB2yk8\$NxujFNGpyo0adR*=ss:I[R%.7kCMdnjx]S2NHs:S#M|%1%2ENRis9aiSis.slNHW:WBxZ%2ogaekBW;ofo0NHS4',
					),
				),
				SizedBox(width: 20,),
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
										DropdownButton<String>(
											value: widget.product.variety.indexOf(widget.product.variety[dropDownValue]).toString(),
											icon: Icon(FlutterIcons.chevron_down_fea),
											iconSize: 24,
											elevation: 16,
											style: TextStyle(color: Colors.deepPurple),
											onChanged: (String newValue) {
												setState(() {
													print(newValue);
												  dropDownValue = int.parse(newValue);
												});
											},
											underline: Container(
												height: 0,
											),
											items: widget.product.variety
												.map<DropdownMenuItem<String>>((String value) {
												return DropdownMenuItem<String>(
													value: widget.product.variety.indexOf(value).toString(),
													child: Text(
														value,
														style: TextStyle(
															fontSize: 20
														),
													),
												);
											}).toList(),
										)
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
										'₹${widget.product.price[dropDownValue]}',
										style: TextStyle(
											color: primaryMain,
											fontWeight: FontWeight.w900,
											fontSize: 35
										),
									),
									color: Colors.white,
								),
								SizedBox(width: 40,),
								if(Provider.of<CartItem>(context).count(widget.product.id, widget.product.variety[dropDownValue]) == 0)...{
									Container(
										decoration: BoxDecoration(
											color: primaryMain,
											borderRadius: BorderRadius.circular(100)
										),
										height: 40,
										child: GestureDetector(
											onTap: () => Provider.of<CartItem>(context).addToCart(ProductCart(
												widget.product.id,
												widget.product.Name,
												widget.product.desc,
												widget.product.price[dropDownValue],
												widget.product.Pic,
												widget.product.hash,
												0,
												widget.product.category,
												widget.product.variety[dropDownValue]
											)),
											child: Row(
												children: <Widget>[
													Padding(
														padding: EdgeInsets.all(10),
														child: Text(
															'Add',
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
																widget.product.price[dropDownValue],
																widget.product.Pic,
																widget.product.hash,
																0,
																widget.product.category,
																widget.product.variety[dropDownValue]
															)),
														),
													),
													SizedBox(width: 5,)
												],
											),
										),
									)
								}
								else...{
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
															widget.product.price[dropDownValue],
															widget.product.Pic,
															widget.product.hash,
															0,
															widget.product.category,
															widget.product.variety[dropDownValue]
														)),
													),
												),
												Padding(
													padding: EdgeInsets.all(10),
													child: Text(
														Provider.of<CartItem>(context).count(widget.product.id, widget.product.variety[dropDownValue]).toString(),
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
															widget.product.price[dropDownValue],
															widget.product.Pic,
															widget.product.hash,
															0,
															widget.product.category,
															widget.product.variety[dropDownValue]
														)),
													),
												),
												SizedBox(width: 5,)
											],
										),
									)
								}
							],
						)
					],
				)
			],
		),
	);
  }
}
