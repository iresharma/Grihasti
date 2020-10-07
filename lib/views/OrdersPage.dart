import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/views/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:customerappgrihasti/components/OrdersBox.dart';
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
      appBar: CustAppBar(),
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
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'There are no previous orders',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(25),
                    fontWeight: FontWeight.w300
                  ),
                  textAlign: TextAlign.center,
                ),
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

