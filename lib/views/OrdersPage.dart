import 'package:customerappgrihasti/Services/filterFirebaseData.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorLoader.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/views/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:customerappgrihasti/components/OrdersBox.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
          child: Builder(
            builder: (context) => AppBar(
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
            ),
          ),
          preferredSize: Size.fromHeight(80.0)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: orders.length == 0
            ? Center(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              SvgPicture.asset(
                'assets/svg/emptyOrder.svg',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              Text(
                'There are no previous orders',
                style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
              ),
            FlatButton(
              child: Text('Shop now ->', style: TextStyle(color: Colors.blue),),
              onPressed: () => Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (_) => HomeScreen())),
            )
          ],
        ),
            )
            : ListView.separated(
          itemCount: orders.length + 1,
          itemBuilder: (context, index) => index == 0 ? Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom:15.0,
                  left: 30.0,
                  right: 30.0
              ),
              child: RaisedButton(
                elevation: 5,
                child: Text(
                  'Filter',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(13)
                  ),
                ),
                color: primaryMain,
                onPressed: () => showCupertinoModalPopup(
                    context: context,
                    builder: (_) => CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          child: Text(
                            'Delivered',
                            style: TextStyle(
                                color: Colors.green
                            ),
                          ),
                          onPressed: () => print('hi'),
                        ),
                        CupertinoActionSheetAction(
                          child: Text(
                            'Active',
                            style: TextStyle(
                                color: Colors.blue
                            ),
                          ),
                          onPressed: () => print('hi'),
                        ),
                        CupertinoActionSheetAction(
                          child: Text(
                            'Placed',
                            style: TextStyle(
                                color: Colors.deepOrangeAccent
                            ),
                          ),
                          onPressed: () => print('hi'),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                ),
                textColor: Colors.white,
              ),
            ),
          ) : Container(
            margin:
            EdgeInsets.only(top: 5, bottom: 0),
            child: OrdersBox(
              order: orders[index - 1],
            ),
          ),
          separatorBuilder: (context, index) {
            return Divider(
              color: primaryMain,
            );
          },
        ),
      ),
    );
  }
}

