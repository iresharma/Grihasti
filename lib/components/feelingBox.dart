import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeelingBox extends StatelessWidget {

	final String asset;
	final String text;
	final String redirect;

  const FeelingBox({Key key, this.asset, this.text, this.redirect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
		margin: EdgeInsets.all(10),
		color: Colors.white,
		child: DottedBorder(
			color: primaryMain,
			strokeWidth: 2,
			dashPattern: [4],
			borderType: BorderType.RRect,
			child: Container(
				padding: EdgeInsets.all(10),
				height: 110,
				width: MediaQuery.of(context).size.width,
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: <Widget>[
						SvgPicture.asset(
							asset,
							width: 100,
							height: 80,
						),
						Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								Container(
									width: MediaQuery.of(context).size.width/2,
									child: Text(
										text,
										style: TextStyle(
											fontSize: 20,
											fontWeight: FontWeight.w400
										),
										textAlign: TextAlign.right,
									),
								),
								FlatButton(
									child: Text(
										'$redirect ->',
										style: TextStyle(
											color: Colors.blue
										),
									),
									onPressed: () => print('Offers'),
								)
							],
						)
					],
				),
			),
		),
	);
  }
}
