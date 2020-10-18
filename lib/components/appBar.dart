import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class CustAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Hero(
        child: IconButton(
          icon: Icon(
            FlutterIcons.ios_arrow_back_ion,
            color: Colors.black38,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        tag: 'Drawer',
      ),
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('G',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: MediaQuery.of(context).size.width * 0.15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Calli2',
                )),
            Text('rihasti',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize:
                    MediaQuery.of(context).size.width * 0.13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Calli'))
          ],
        ),
      ),
      actions: <Widget>[
        Hero(
          child: IconButton(
            icon: Icon(
              FlutterIcons.search1_ant,
              color: Colors.black38,
            ),
            onPressed: () => print('hi'),
          ),
          tag: 'Search',
        ),
        Hero(
          child: IconButton(
            icon: FlutterBadge(
              itemCount: Provider.of<CartItem>(context).len,
              badgeColor: Colors.greenAccent,
              icon: Icon(
                FlutterIcons.cart_evi,
                size: 35,
                color: Colors.black38,
              ),
              badgeTextColor: Colors.black38,
              contentPadding: EdgeInsets.all(7),
            ),
            onPressed: () => Navigator.of(context).pushNamed('/cart'),
          ),
          tag: 'Cart',
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
