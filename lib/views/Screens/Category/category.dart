import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/colorLoader.dart';
import 'package:customerappgrihasti/views/Screens/Poducts/components/productSquareBox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Categor extends StatefulWidget {

	final String cate;

  const Categor({Key key, this.cate}) : super(key: key);

  @override
  _CategorState createState() => _CategorState();
}

class _CategorState extends State<Categor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
		appBar: AppBar(
			title: Text('GRIHASTI'),
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.only(
					bottomRight: Radius.circular(20),
					bottomLeft: Radius.circular(20)
				)
			),
		),
		body: StreamBuilder(
			stream: Firestore.instance.collection('categories').where('name', isEqualTo: widget.cate).snapshots(),
			builder: (context, snapshot) {
				if(!snapshot.hasData) {
					return Center(
						child: CircularProgressIndicator(),
					);
				}
				else {
					return Column(
						children: <Widget>[
							Padding(
								padding: EdgeInsets.only(top: 20, left: 20),
								child: Align(
									alignment: Alignment.topLeft,
									child: Text(
										'Categories',
										style: TextStyle(
											fontWeight: FontWeight.w300,
											fontSize: 40
										),
									),
								),
							),
							Container(
								height: MediaQuery.of(context).size.height - 152.7,
								child: ListView.builder(
									itemCount: snapshot.data.documents[0].data['subCategories'].length,
									itemBuilder: (context, index) {
										return Padding(
											padding: EdgeInsets.only(
												bottom: 20,
												left: 15
											),
											child: Card(
												elevation: 2,
												child: Container(
													padding: EdgeInsets.all(5),
													height: 600,
													width: MediaQuery.of(context).size.width,
													child: Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: <Widget>[
															Row(
																children: <Widget>[
																	Text(
																		'Best deals ${snapshot.data.documents[0].data['subCategories'][index]['name']}',
																		style: TextStyle(
																			fontSize: 25,
																			fontWeight: FontWeight.w300
																		),
																	),
																	Icon(FlutterIcons.chevron_right_fea)
																],
															),
															Divider(),
															StreamBuilder(
																stream: Firestore.instance.collection('product').snapshots(),
																builder: (context, snapshot) {
																	if(!snapshot.hasData) {
																		return Center(
																			child: ColorLoader4(),
																		);
																	}
																	else {
																		return Container(
																			width: MediaQuery.of(context).size.width,
																			height: 540,
																			child: ListView.builder(
																				itemCount: (snapshot.data.documents.length/2).round(),
																				scrollDirection: Axis.horizontal,
																				shrinkWrap: true,
																				itemBuilder: (context, index) {
																					print(snapshot.data.documents[index].data['Desc']);
																					return Column(
																						children: <Widget>[
																							ProductSquareBox(
																								productId: snapshot.data.documents[index].documentID,
																								desc: snapshot.data.documents[index].data['Desc'],
																								Name: snapshot.data.documents[index].data['Name'],
																								price: snapshot.data.documents[index].data['Price'],
																							),
																							ProductSquareBox(
																								Name: snapshot.data.documents[index + 2].data['Name'],
																								desc: snapshot.data.documents[index + 2].data['Desc'],
																								price: snapshot.data.documents[index + 2].data['Price'],
																								productId: snapshot.data.documents[index + 2].documentID,
																							)
																						],
																					);
																				},
																			),
																		);
																	}
																},
															)
														],
													),
												),
											),
										);
									}
								),
							)
						],
					);
				}
			},
		),
	);
  }
}
