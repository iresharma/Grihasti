import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {

	TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
		backgroundColor: Colors.white,
		appBar: PreferredSize(
			preferredSize: Size.fromHeight(80.0),
			child: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0,
				flexibleSpace: SafeArea(
					child: Row(
						crossAxisAlignment: CrossAxisAlignment.start,
						mainAxisAlignment: MainAxisAlignment.center,
						children: <Widget>[
							Text(
								'G',
								style: TextStyle(
									color: Colors.black87,
									fontSize: MediaQuery.of(context).size.width * 0.15,
									fontWeight: FontWeight.w400,
									fontFamily: 'Calli2',
								)
							),
							Text(
								'rihasti',
								style: TextStyle(
									color: Colors.black87,
									fontSize: MediaQuery.of(context).size.width * 0.13,
									fontWeight: FontWeight.w400,
									fontFamily: 'Calli'
								)
							)
						],
					),
				),
				leading: IconButton(
					icon: Icon(FlutterIcons.back_ant), color: Colors.black,
					onPressed: () => Navigator.of(context).pop(),
				),
			),
		),
		body: Theme(
			data: ThemeData(
				canvasColor: Colors.white
			),
			child: FloatingSearchBar.builder(
				itemCount: Provider.of<Search>(context).len == 0 ? Activeuser.recentlySearch.length : Provider.of<Search>(context).len,
				pinned: true,
				onChanged: (value) => Provider.of<Search>(context).search(value),
				itemBuilder: (BuildContext context, int index) {
					if(Provider.of<Search>(context).len == 0) {
						return GestureDetector(
								onTap: () {
									print('=================${Activeuser.recentlySearch[index].categoryId}');
									Navigator.of(context).pushNamed('/searchResult', arguments: Activeuser.recentlySearch[index]);
								},
								child: Padding(
									padding: const EdgeInsets.only(
											left: 18,
											right: 18
									),
									child: ListTile(
										title: Text(
												Activeuser.recentlySearch[index].name,
											style: TextStyle(
												color: Colors.deepPurple,
												fontWeight: FontWeight.w600
											),
										),
										subtitle: Text(
												Activeuser.recentlySearch[index].type,
												style: TextStyle(
														color: Colors.deepPurpleAccent
												),
										),
										trailing: Icon(FlutterIcons.chevron_right_ent),
										leading: Icon(FlutterIcons.search1_ant),
									),
								)
						);
					}
					else {
						return GestureDetector(
							onTap: () {
								print('${Provider.of<Search>(context).searchResult[index].categoryId}=================');
								Provider.of<Search>(context).addrecent(Provider.of<Search>(context).searchResult[index]);
								Firestore.instance.collection('users').document(Activeuser.Uid).updateData({
									'searched': Provider.of<Search>(context).deprocess(Activeuser.recentlySearch)
								});
								Navigator.of(context).pushNamed('/searchResult', arguments: Provider.of<Search>(context).searchResult[index]);
							},
							child: Padding(
								padding: const EdgeInsets.only(
										left: 18,
										right: 18
								),
								child: ListTile(
									title: Text(
											Provider.of<Search>(context).searchResult[index].name
									),
									subtitle: Text(
											Provider.of<Search>(context).searchResult[index].type
									),
									trailing: Icon(FlutterIcons.chevron_right_ent),
									leading: Icon(FlutterIcons.search1_ant),
								),
							),
						);
					}
				},
				decoration: InputDecoration(
					border: InputBorder.none,
					floatingLabelBehavior: FloatingLabelBehavior.never,
					labelText: 'Search...',
					fillColor: Colors.white,
				),
				controller: _controller,
				trailing: CircleAvatar(
					child: Icon(FlutterIcons.search1_ant, color: secondarySec,),
					backgroundColor: primaryMain,
					foregroundColor: Colors.transparent,
				),
			),
		),
	);
  }
}
