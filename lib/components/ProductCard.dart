import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ProductCard extends StatelessWidget {
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
						image: Top[0].Pic,
						hash: 'qEHV6nWB2yk8\$NxujFNGpyo0adR*=ss:I[R%.7kCMdnjx]S2NHs:S#M|%1%2ENRis9aiSis.slNHW:WBxZ%2ogaekBW;ofo0NHS4',
					),
				),
				SizedBox(width: 20,),
				Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						Text(
							Top[0].Name,
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
										Text(
											'1kg',
											style: TextStyle(
												fontWeight: FontWeight.w400,
												fontSize: 20
											),
										)
									],
								)
							],
						),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: <Widget>[
								Text(
									'₹${Top[0].price}',
									style: TextStyle(
										color: primaryMain,
										fontWeight: FontWeight.w900,
										fontSize: 20
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
