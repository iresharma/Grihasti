import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    super.initState();
    dropDownValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
			onTap: () => Navigator.of(context).pushNamed('/product', arguments: widget.product.id),
      child: Container(
		width: ScreenUtil.defaultWidth * 1.0,
		height: ScreenUtil.defaultHeight/11 - 10,
		margin: EdgeInsets.all(5),
		padding: EdgeInsets.all(5),
		decoration: BoxDecoration(
			borderRadius: BorderRadius.circular(10),
			color: Colors.white
		),
		child: Row(
			children: <Widget>[
				SizedBox(
					width: MediaQuery.of(context).size.width > 450 ? MediaQuery.of(context).size.width/3 : MediaQuery.of(context).size.width/4,
					height: MediaQuery.of(context).size.width > 450 ? ScreenUtil.defaultHeight/11.5 : MediaQuery.of(context).size.width/4,
					child: BlurHash(
						image: widget.product.thumb,
						hash: widget.product.hash
					),
				),
				SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
				Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						Text(
							widget.product.Name,
							style: TextStyle(
								fontSize: MediaQuery.of(context).size.width > 450 ? ScreenUtil().setSp(15) : ScreenUtil().setSp(18),
								fontWeight: FontWeight.w800
							),
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Container(
									width: MediaQuery.of(context).size.width * 0.33,
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Text(
												'Category',
												style: TextStyle(
													fontWeight: FontWeight.w200,
													fontSize: ScreenUtil().setSp(10)
												),
											),
											Text(
												widget.product.category,
												style: TextStyle(
													fontWeight: FontWeight.w400,
													fontSize: ScreenUtil().setSp(13),
												),
												overflow: TextOverflow.ellipsis,
											)
										],
									),
								),
								SizedBox(
									width: MediaQuery.of(context).size.width * 0.05,
								),
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: <Widget>[
										Text(
											'Varient',
											style: TextStyle(
												fontWeight: FontWeight.w200,
												fontSize: ScreenUtil().setSp(10)
											),
										),
										DropdownButton<String>(
											value: widget.product.variety.indexOf(widget.product.variety[dropDownValue]).toString(),
											icon: Icon(FlutterIcons.chevron_down_fea, color: primaryMain,),
											iconSize: ScreenUtil().setSp(15),
											elevation: 16,
											style: TextStyle(
												color: Colors.deepPurple,
												fontSize: ScreenUtil().setSp(20),
											),
											onChanged: (String newValue) {
												setState(() {
													print(newValue);
												  dropDownValue = int.parse(newValue);
												});
											},
											underline: Container(
												height: 0,
											),
											focusColor: Colors.white,
											dropdownColor: Colors.white,
											items: widget.product.variety
												.map<DropdownMenuItem<String>>((String value) {
												return DropdownMenuItem<String>(
													value: widget.product.variety.indexOf(value).toString(),
													child: Text(
														value,
														style: TextStyle(
															fontSize: MediaQuery.of(context).textScaleFactor * 15,
														),
													),
												);
											}).toList(),
										)
									],
								)
							],
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Container(
									width: MediaQuery.of(context).size.width * 0.33,
									child: Text(
										'₹${widget.product.price[dropDownValue]}',
										style: TextStyle(
											color: primaryMain,
											fontWeight: FontWeight.w900,
											fontSize: ScreenUtil().setSp(20)
										),
									),
								),
								if(Provider.of<CartItem>(context).count(widget.product.id, widget.product.variety[dropDownValue]) == 0)...{
									SizedBox(
										width: MediaQuery.of(context).size.width * 0.05,
									),
									Container(
										decoration: BoxDecoration(
											color: primaryMain,
											borderRadius: BorderRadius.circular(100)
										),
										height: 35,
										child: GestureDetector(
											onTap: () => Provider.of<CartItem>(context).addToCart(ProductCart(
												widget.product.id,
												widget.product.Name,
												widget.product.desc,
												widget.product.price[dropDownValue],
												widget.product.thumb,
												widget.product.hash,
												1,
												widget.product.category,
												widget.product.variety[dropDownValue],
												widget.product.pictures
											)),
											child: Row(
												children: <Widget>[
													Padding(
														padding: EdgeInsets.only(
															left: 10,
															top: 5,
															right: 5,
															bottom: 5
														),
														child: Text(
															'Add',
															style: TextStyle(
																color: Colors.white,
																fontWeight: FontWeight.w700,
																fontSize: MediaQuery.of(context).textScaleFactor * 15
															),
														),
													),
													Container(
														height: 27,
														width: 30,
														padding: EdgeInsets.all(0),
														child: MaterialButton(
															shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
															child: Text(
																'+',
																style: TextStyle(
																	color: primaryMain,
																	fontSize: MediaQuery.of(context).textScaleFactor * 27,
																	fontWeight: FontWeight.w400
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
																widget.product.thumb,
																widget.product.hash,
																1,
																widget.product.category,
																widget.product.variety[dropDownValue],
																widget.product.pictures
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
									SizedBox(
										width: MediaQuery.of(context).size.width * 0.02,
									),
									Container(
										decoration: BoxDecoration(
											color: primaryMain,
											borderRadius: BorderRadius.circular(100)
										),
										height: 35,
										child: Row(
											children: <Widget>[
												SizedBox(width: 5,),
												Container(
													height: 27,
													width: 30,
													padding: EdgeInsets.all(0),
													child: MaterialButton(
														shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
														child: Text(
															'-',
															style: TextStyle(
																color: primaryMain,
																fontSize: MediaQuery.of(context).textScaleFactor * 27,
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
															widget.product.thumb,
															widget.product.hash,
															0,
															widget.product.category,
															widget.product.variety[dropDownValue],
															widget.product.pictures
														)),
													),
												),
												Padding(
													padding: EdgeInsets.all(5),
													child: Text(
														Provider.of<CartItem>(context).count(widget.product.id, widget.product.variety[dropDownValue]).toString(),
														style: TextStyle(
															color: Colors.white,
															fontWeight: FontWeight.w700,
															fontSize: MediaQuery.of(context).textScaleFactor * 15
														),
													),
												),
												Container(
													height: 27,
													width: 30,
													padding: EdgeInsets.all(0),
													child: MaterialButton(
														shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
														child: Text(
															'+',
															style: TextStyle(
																color: primaryMain,
																fontSize: MediaQuery.of(context).textScaleFactor * 27,
																fontWeight: FontWeight.w400
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
															widget.product.thumb,
															widget.product.hash,
															0,
															widget.product.category,
															widget.product.variety[dropDownValue],
															widget.product.pictures
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
	),
    );
  }
}

