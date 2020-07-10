import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfferBox extends StatelessWidget {

	final String main;
	final String fineprint;
	final int index;

	OfferBox(this.main, this.index, this.fineprint);

	List<Color> offerBox = [
		Colors.deepPurpleAccent.shade100,
		Colors.green.shade400,
		Colors.blue.shade400,
		Colors.orangeAccent.shade100
	];

  @override
  Widget build(BuildContext context) {
    return Container(
		width: MediaQuery.of(context).size.width/2 - 30,
		height: 100,
		margin: EdgeInsets.all(5),
		padding: EdgeInsets.all(10),
		decoration: BoxDecoration(
			color: offerBox[(index)%4],
			borderRadius: BorderRadius.circular(3)
		),
		child: Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						Text(
							'₹${main}',
							style: TextStyle(
								fontSize: 30,
								fontWeight: FontWeight.w900,
								color: Colors.white
							),
						),
						Container(
							width: MediaQuery.of(context).size.width/2 - MediaQuery.of(context).size.width/4,
							child: Text(
								'''${fineprint}''',
								style: TextStyle(
									fontSize: 15,
									fontWeight: FontWeight.w400,
									color: Colors.white,
								),
							),
						)
					],
				),
				SvgPicture.asset(
					'assets/svg/emptyCart.svg',
					width: 60,
					height: 60,
				)
			],
		),
	);
  }
}
