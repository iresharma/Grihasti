import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
		width: ScreenUtil.defaultWidth * 1.0,
		height: ScreenUtil.defaultHeight/11 - 10,
		margin: EdgeInsets.all(5),
		padding: EdgeInsets.all(10),
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
						image: widget.product.Pic,
						hash: widget.product.hash,
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
								fontSize: ScreenUtil().setSp(18),
								fontWeight: FontWeight.w800
							),
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Container(
									padding: EdgeInsets.only(
										left: 10,
										right: 10
									),
									width: MediaQuery.of(context).size.width * 0.33,
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: <Widget>[
											Text(
												'Category',
												style: TextStyle(
													fontWeight: FontWeight.w200,
													fontSize:ScreenUtil().setSp(10)
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
										Text(
											'${widget.product.variety}',
											style: TextStyle(
												fontWeight: FontWeight.w400,
												fontSize: ScreenUtil().setSp(12)
											),
										),
									],
								)
							],
						),
						SizedBox(height:  MediaQuery.of(context).size.height * 0.02,),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Container(
									width: MediaQuery.of(context).size.width/4,
									child: Text(
										'₹${widget.product.price}',
										style: TextStyle(
											color: primaryMain,
											fontWeight: FontWeight.w900,
											fontSize: ScreenUtil().setSp(20)
										),
									),
									color: Colors.white,
								),
								SizedBox(
									width: MediaQuery.of(context).size.width * 0.12,
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
												width: 27,
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
												padding: EdgeInsets.all(5),
												child: Text(
													Provider.of<CartItem>(context).count(widget.product.id, widget.product.variety).toString(),
													style: TextStyle(
														color: Colors.white,
														fontWeight: FontWeight.w700,
														fontSize: MediaQuery.of(context).textScaleFactor * 15
													),
												),
											),
											Container(
												height: 27,
												width: 27,
												padding: EdgeInsets.all(0),
												child: MaterialButton(
													shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
													child: Text(
														'+',
														style: TextStyle(
															color: primaryMain,
															fontSize: MediaQuery.of(context).textScaleFactor * 27,
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
