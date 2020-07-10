import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

import 'btnWithIcon.dart';

class ProductCard extends StatefulWidget {

	final int index;

  const ProductCard({Key key, this.index}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

	String dropdownValue = '1Kg';

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
						image: Top[widget.index].Pic,
						hash: 'qEHV6nWB2yk8\$NxujFNGpyo0adR*=ss:I[R%.7kCMdnjx]S2NHs:S#M|%1%2ENRis9aiSis.slNHW:WBxZ%2ogaekBW;ofo0NHS4',
					),
				),
				SizedBox(width: 20,),
				Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						Text(
							Top[widget.index].Name,
							style: TextStyle(
								fontSize: 20,
								fontWeight: FontWeight.w800
							),
						),
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
											'Personal Care',
											style: TextStyle(
												fontWeight: FontWeight.w400,
												fontSize: 20
											),
										)
									],
								),
								SizedBox(width: 60,),
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
											value: dropdownValue,
											icon: Icon(Icons.arrow_downward),
											iconSize: 24,
											elevation: 16,
											style: TextStyle(color: Colors.deepPurple),
											underline: Container(
												height: 2,
												color: primaryMain,
											),
											onChanged: (String newValue) {
												setState(() {
													dropdownValue = newValue;
												});
											},
											items: <String>['1Kg', '2Kg', '5Kg', '10Kg']
												.map<DropdownMenuItem<String>>((String value) {
												return DropdownMenuItem<String>(
													value: value,
													child: Text(value),
												);
											}).toList(),
										)
									],
								)
							],
						),
						SizedBox(height: 30,),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Container(
									width: 120,
									child: Text(
										'₹${Top[widget.index].price}',
										style: TextStyle(
											color: primaryMain,
											fontWeight: FontWeight.w900,
											fontSize: 35
										),
									),
									color: Colors.white,
								),
								SizedBox(width: 40,),
								if(Provider.of<CartItem>(context).count(Top[widget.index].id) == 0)...{
									Container(
										decoration: BoxDecoration(
											color: primaryMain,
											borderRadius: BorderRadius.circular(100)
										),
										height: 40,
										child: GestureDetector(
											onTap: () => Provider.of<CartItem>(context).addToCart(Top[widget.index]),
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
															onPressed: () => Provider.of<CartItem>(context).addToCart(Top[widget.index]),
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
														onPressed: () => Provider.of<CartItem>(context).removeFromCart(Top[widget.index]),
													),
												),
												Padding(
													padding: EdgeInsets.all(10),
													child: Text(
														Provider.of<CartItem>(context).count(Top[widget.index].id).toString(),
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
														onPressed: () => Provider.of<CartItem>(context).addToCart(Top[widget.index]),
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

