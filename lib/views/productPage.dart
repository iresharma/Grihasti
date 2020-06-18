import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/btn1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductPAge extends StatefulWidget {

	final String productId;
	final String name;

  const ProductPAge({Key key, this.productId, this.name}) : super(key: key);

  @override
  _ProductPAgeState createState() => _ProductPAgeState();
}

class _ProductPAgeState extends State<ProductPAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			title: Text(widget.name),
			actions: <Widget>[
				IconButton(
					icon: Icon(FlutterIcons.share_2_fea),
					color: Colors.white,
					onPressed: () => print('share'),
				)
			],
		),
		body: SingleChildScrollView(
			child: Column(
				children: <Widget>[
					FutureBuilder(
						future: Firestore.instance.collection('product').document(widget.productId).get(),
						builder: (context, snapshot) {
							if(!snapshot.hasData) {
								return Center(
									child: CircularProgressIndicator(),
								);
							}
							else {
								print(snapshot.data.exists);
								return SingleChildScrollView(
									child: Padding(
										padding: EdgeInsets.only(
											left: 5
										),
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: <Widget>[
												Container(
													height: MediaQuery.of(context).size.height/2,
													decoration: BoxDecoration(
														borderRadius: BorderRadius.only(
															bottomLeft: Radius.circular(10),
															bottomRight: Radius.circular(10)
														)
													),
													child: Center(
														child: Image.network(
															snapshot.data.data['Pic'],
															height: MediaQuery.of(context).size.height/2,
															scale: 0.4,
														)
													),
												),
												SizedBox(height: 10,),
												Text(
													widget.name,
													style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
												),
												SizedBox(height: 5,),
												Text(
													'Description',
													style: TextStyle(
														fontSize: 15,
														fontWeight: FontWeight.w400
													),
												),
												Divider(thickness: 1.5,),
												Text(
													snapshot.data.data['Desc'],
													style: TextStyle(
														fontSize: 15,
														fontWeight: FontWeight.w200
													),
												),
												SimpleRoundButton(
													backgroundColor: Colors.orange,
													textColor: Colors.white,
													buttonText: Text(
														'Add to cart',
														style: TextStyle(
															color: Colors.white
														),
													),
													onPressed: () => print('Added to cart'),
												)
											],
										),
									),
								);
							}
						},
					)
				],
			),
		),
	);
  }
}
