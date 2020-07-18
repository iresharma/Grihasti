import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBox extends StatefulWidget {

	final Category cat;

	CategoryBox({this.cat});

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {

	bool animate;

	@override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate = false;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
		duration: Duration(milliseconds: 250),
		height: animate ? MediaQuery.of(context).size.height/5 : MediaQuery.of(context).size.height/12,
		color: Colors.white,
		margin: EdgeInsets.only(
			right: ScreenUtil().setSp(10),
			left: ScreenUtil().setSp(10),
			top: ScreenUtil().setSp(5),
			bottom: ScreenUtil().setSp(5)
		),
		padding: EdgeInsets.all(10),
		child: animate ? Column(
			children: <Widget>[
				Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						Text(
							widget.cat.name,
							style: TextStyle(
								fontWeight: FontWeight.w300,
								fontSize: ScreenUtil().setSp(20)
							),
						),
						IconButton(
							icon: Icon(FlutterIcons.chevron_up_ent),
							onPressed: () {
								setState(() {
									animate = !animate;
								});
							},
						)
					],
				),
				Divider(thickness: 2,),
				SizedBox(
					width: MediaQuery.of(context).size.width - 40,
					height: MediaQuery.of(context).size.width/5,
					child: AnimatedOpacity(
						duration: Duration(milliseconds: 300),
						opacity: animate ? 1 : 0,
						child: ListView.builder(
							physics: NeverScrollableScrollPhysics(),
							itemCount: 4,
							scrollDirection: Axis.horizontal,
							itemBuilder: (context, index) => index == 3 ? Container(
								margin: EdgeInsets.all(0),
								height: MediaQuery.of(context).size.width/4,
								padding: EdgeInsets.all(ScreenUtil().setSp(10)),
								child: Center(
									child: Icon(FlutterIcons.chevron_circle_right_faw, color: primaryMain, size: ScreenUtil().setSp(30),),
								),
							) : SizedBox(
								width: MediaQuery.of(context).size.width/4,
								child: Column(
									children: <Widget>[
										Image.asset(
											widget.cat.sub[index]['icon'] == '' ? 'assets/icons/about_us.png' : widget.cat.sub[index]['icon'],
											height: MediaQuery.of(context).size.width/5 - ScreenUtil().setSp(20),
											width: MediaQuery.of(context).size.width/5 - ScreenUtil().setSp(20),
										),
										Text(
											widget.cat.sub[index]['name'],
											style: TextStyle(
												fontSize: ScreenUtil().setSp(10),
												fontWeight: FontWeight.w300
											),
											overflow: TextOverflow.ellipsis,
										)
									],
								),
							),
						),
					),
				)
			],
		) : Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: <Widget>[
				Text(
					widget.cat.name,
					style: TextStyle(
						fontWeight: FontWeight.w300,
						fontSize: ScreenUtil().setSp(20)
					),
				),
				IconButton(
					icon: Icon(FlutterIcons.chevron_down_ent),
					onPressed: () {
						setState(() {
						  animate = !animate;
						});
					},
				)
			],
		)
	);
  }
}
