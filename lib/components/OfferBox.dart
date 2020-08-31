import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OfferBox extends StatelessWidget {
  final String main;
  final String fineprint;
  final int index;
  final String code;
  final String icon;

  OfferBox(this.main, this.index, this.fineprint, this.code, this.icon);

  List<Color> offerBox = [
    Colors.deepPurpleAccent.shade100,
    Colors.green.shade400,
    Colors.blue.shade400,
    Colors.orangeAccent.shade100
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
			onTap: () {
				Clipboard.setData(new ClipboardData(text: code));
				Fluttertoast.showToast(
					msg: 'Coupon code \'${code}\', copied to your clipbosrd',
					toastLength: Toast.LENGTH_LONG,
					gravity: ToastGravity.TOP,
					backgroundColor: Colors.grey
				);
			},
      child: Container(
        width: MediaQuery.of(context).size.width / 2 + 30,
        height: 150,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: offerBox[(index) % 4], borderRadius: BorderRadius.circular(3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  '${main}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 -
                      MediaQuery.of(context).size.width / 4,
                  child: Text(
                    '''${fineprint}''',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(10),
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SvgPicture.network(
              icon,
              width: MediaQuery.of(context).size.width / 5,
            )
          ],
        ),
      ),
    );
  }
}
