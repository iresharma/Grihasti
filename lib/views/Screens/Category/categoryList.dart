import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'components/categoryBox.dart';

class Catlist extends StatefulWidget {
  @override
  _CatlistState createState() => _CatlistState();
}

class _CatlistState extends State<Catlist> {


	List<List<Color>> gradient = [
		[
			Color(0xffFCE183),
			Color(0xffF68D7F),
		],
		[
			Color(0xffF749A2),
			Color(0xffFF7375),
		],
		[
			Color(0xff00E9DA),
			Color(0xff5189EA),
		],
		[
			Color(0xffAF2D68),
			Color(0xff632376),
		],
		[
			Color(0xff36E892),
			Color(0xff33B2B9),
		],
		[
			Color(0xffF123C4),
			Color(0xff668CEA),
		]
	];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
		body: StreamBuilder(
			stream: Firestore.instance.collection('customer').snapshots(),
			builder: (context, snapshot) {
				if(snapshot.hasData) {
					return ListView.builder(
						itemCount: snapshot.data.documents.length,
						itemBuilder: (context, index) {
							return Padding(
								padding: EdgeInsets.symmetric(
									horizontal: 10,
									vertical: 5
								),
								child: CategoryBox(
									begin: gradient[index%6][0],
									end: gradient[index%6][1],
									categoryName: snapshot.data.documents[index].data['Name'],
								),
							);
						},
					);
				}
				else {
					return Center(
						child: CircularProgressIndicator()
					);
				}
			},
		),
	);
  }
}
