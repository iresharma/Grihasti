import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/views/viewOrder.dart';
import 'package:flutter/material.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrdersBox extends StatelessWidget {
  final Order order;

  OrdersBox({this.order});

  String processTime(String arg) {
    int time = int.parse(arg);
    DateTime order = new DateTime.fromMicrosecondsSinceEpoch(time);
    return order.day.toString() + '/' + order.month.toString() + '/' + order.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.height/3 : MediaQuery.of(context).size.height/3 + ScreenUtil().setSp(20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Ordered on ${processTime(order.ordered_on)}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(10)
            ),
          ),
          SizedBox(height: ScreenUtil().setSp(5)),
          Container(
            padding: EdgeInsets.all(ScreenUtil().setSp(8)),
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.black38, width: 0.5),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height/5,
                  padding: EdgeInsets.only(
                    top: 10,
                    right: 10,
                    left: 10
                  ),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'G  ',
                              style: TextStyle(
                                fontFamily: 'Calli2',
                                fontSize: ScreenUtil().setSp(12),
                                color: primaryMain
                              )
                            ),
                            TextSpan(
                              text: 'Delivered by ',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(9),
                                  color: Colors.black54
                                )
                            ),
                            TextSpan(
                                text: ' G',
                                style: TextStyle(
                                    fontFamily: 'Calli2',
                                    fontSize: ScreenUtil().setSp(12),
                                    color: Colors.black
                                )
                            ),
                            TextSpan(
                                text: 'rihasti',
                                style: TextStyle(
                                    fontFamily: 'Calli',
                                    fontSize: ScreenUtil().setSp(10),
                                    color: Colors.black
                                )
                            ),
                          ]
                        ),
                      ),
                      Divider(thickness: 1,),
                      Container(
                        height: MediaQuery.of(context).size.height/7 - ScreenUtil().setSp(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  'Order amount',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(10)
                                  ),
                                ),
                                Text(
                                  'Discount amount',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10)
                                  ),
                                ),

                                Text(
                                  'Order ID: ${order.id}',
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(12),
                                      fontWeight: FontWeight.w200
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(FlutterIcons.check_circle_fea, color: Colors.green,),
                                    SizedBox(width: 10,),
                                    Text('Delivered', style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      color: Colors.green
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    '₹ ${order.price}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(12)
                                    ),
                                  ),
                                  Text(
                                    'Discount amount',
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(10),
                                      color: primaryMain
                                    ),
                                  ),
                                ]
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: RaisedButton(
                    color: Colors.deepOrangeAccent,
                    child: Text('View Order'),
                    onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (_) => viewOrder(order: order,))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}