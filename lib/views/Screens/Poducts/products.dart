import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/components/colorLoader.dart';
import 'package:customerappgrihasti/views/Screens/Poducts/components/productSquareBox.dart';
import 'package:customerappgrihasti/views/Screens/Poducts/components/productofferbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

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
			Color(0xff5189EA),
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
    return SingleChildScrollView(
		child: Column(
			children: <Widget>[
				Padding(
					padding: EdgeInsets.symmetric(
						vertical: 20
					),
					child: StreamBuilder(
						stream: Firestore.instance.collection('customer').snapshots(),
						builder: (context, snapshot) {
							if(!snapshot.hasData) {
								return Center(
									child: ColorLoader(),
								);
							}
							else {
								return CarouselSlider.builder(
									itemCount: snapshot.data.documents.length,
									itemBuilder: (context, index) {
										return ProductPageOfferBox(
											begin: gradient[index%6][0],
											end: gradient[index%6][1],
											icon: Icon(
												FlutterIcons.user_astronaut_faw5s,
												size: 50,
											),
											finePrint: snapshot.data.documents[index].data['Email'],
											offerText: snapshot.data.documents[index].data['Name'],
										);
									},
									options: CarouselOptions(
										height: 200,
										aspectRatio: 16/9,
										viewportFraction: 0.8,
										initialPage: 0,
										enableInfiniteScroll: true,
										reverse: false,
										autoPlay: true,
										autoPlayInterval: Duration(seconds: 2),
										autoPlayAnimationDuration: Duration(milliseconds: 700),
										autoPlayCurve: Curves.fastOutSlowIn,
										enlargeCenterPage: true,
										onPageChanged: (int, x) => print('chnge$int'),
										scrollDirection: Axis.horizontal,
									)
								);
							}
						},
					),
				),
				Padding(
					padding: EdgeInsets.only(
						left: 15
					),
					child: Card(
						elevation: 0,
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
												'Top products',
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
													child: Scrollbar(
														child: ListView.builder(
															itemCount: (snapshot.data.documents.length/2).round(),
															scrollDirection: Axis.horizontal,
															shrinkWrap: true,
															itemBuilder: (context, index) {
																return Column(
																	children: <Widget>[
																		if(index%2 == 0)...{
																			ProductSquareBox(
																				Name: snapshot.data.documents[index].data['Name'],
																				desc: snapshot.data.documents[index].data['Desc'],
																				price: snapshot.data.documents[index].data['Price'],
																				productId: snapshot.data.documents[index].documentID,
																			),
																			Divider(
																				thickness: 2,
																				color: Colors.black,
																			),
																			ProductSquareBox(
																				Name: snapshot.data.documents[index + 1].data['Name'],
																				desc: snapshot.data.documents[index + 1].data['Desc'],
																				price: snapshot.data.documents[index + 1].data['Price'],
																				productId: snapshot.data.documents[index + 1].documentID,
																			),
																		}
																	],
																);
															},
														),
													),
												);
											}
										},
									)
								],
							),
						),
					),
				),
				Padding(
					padding: EdgeInsets.only(
						left: 15
					),
					child: Card(
						elevation: 0,
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
												'Previous ordered',
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
															return Column(
																children: <Widget>[
																	if(index%2 == 0)...{
																		ProductSquareBox(
																			Name: snapshot.data.documents[index].data['Name'],
																			desc: snapshot.data.documents[index].data['Desc'],
																			price: snapshot.data.documents[index].data['Price'],
																			productId: snapshot.data.documents[index].documentID,
																		),
																		Divider(
																			thickness: 2,
																			color: Colors.black,
																		),
																		ProductSquareBox(
																			Name: snapshot.data.documents[index + 1].data['Name'],
																			desc: snapshot.data.documents[index + 1].data['Desc'],
																			price: snapshot.data.documents[index + 1].data['Price'],
																			productId: snapshot.data.documents[index + 1].documentID,
																		),
																	}
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
				),
				Padding(
					padding: EdgeInsets.symmetric(
						vertical: 20
					),
					child: StreamBuilder(
						stream: Firestore.instance.collection('customer').snapshots(),
						builder: (context, snapshot) {
							if(!snapshot.hasData) {
								return Center(
									child: ColorLoader(),
								);
							}
							else {
								return CarouselSlider.builder(
									itemCount: snapshot.data.documents.length,
									itemBuilder: (context, index) {
										return ProductPageOfferBox(
											begin: gradient[index%6][0],
											end: gradient[index%6][1],
											icon: Icon(
												FlutterIcons.user_astronaut_faw5s,
												size: 50,
											),
											finePrint: snapshot.data.documents[index].data['Email'],
											offerText: snapshot.data.documents[index].data['Name'],
										);
									},
									options: CarouselOptions(
										height: 200,
										aspectRatio: 16/9,
										viewportFraction: 0.8,
										initialPage: 0,
										enableInfiniteScroll: true,
										reverse: false,
										autoPlay: true,
										autoPlayInterval: Duration(seconds: 2),
										autoPlayAnimationDuration: Duration(milliseconds: 700),
										autoPlayCurve: Curves.fastOutSlowIn,
										enlargeCenterPage: true,
										onPageChanged: (int, x) => print('chnge$int'),
										scrollDirection: Axis.horizontal,
									)
								);
							}
						},
					),
				),
				Padding(
					padding: EdgeInsets.only(
						left: 15
					),
					child: Card(
						elevation: 0,
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
												'Best deals on daily items',
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
															return Column(
																children: <Widget>[
																	if(index%2 == 0)...{
																		ProductSquareBox(
																			Name: snapshot.data.documents[index].data['Name'],
																			desc: snapshot.data.documents[index].data['Desc'],
																			price: snapshot.data.documents[index].data['Price'],
																			productId: snapshot.data.documents[index].documentID,
																		),
																		Divider(
																			thickness: 2,
																			color: Colors.black,
																		),
																		ProductSquareBox(
																			Name: snapshot.data.documents[index + 1].data['Name'],
																			desc: snapshot.data.documents[index + 1].data['Desc'],
																			price: snapshot.data.documents[index + 1].data['Price'],
																			productId: snapshot.data.documents[index + 1].documentID,
																		),
																	}
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
				)
			],
		),
	  );
  }
}
