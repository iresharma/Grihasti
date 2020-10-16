import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:customerappgrihasti/views/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:customerappgrihasti/components/OrdersBox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  bool filter;
  List<Order> filtered;

  @override
  void initState() {
    super.initState();
    filter = false;
    filtered = [];
  }

  VoidCallback showAction() {
    showCupertinoModalPopup(
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
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => filter = true);
                filterOrders('delivered');
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Ordered',
                style: TextStyle(
                    color: Colors.blue
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => filter = true);
                filterOrders('ordered');
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Canceled',
                style: TextStyle(
                    color: Colors.deepOrangeAccent
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => filter = true);
                filterOrders('canceled');
              },
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
    );
  }

  void filterOrders(String state) {
    setState(() {
      filtered = orders.where((element) => element.status == state).toList();
    });
    print(filtered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustAppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: orders.length == 0
            ? Center( // No orders logic is here
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
          itemCount: filter ? filtered.length + 1 : orders.length + 1,
          itemBuilder: (context, index) => index == 0 ? filter ? Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom:15.0,
                  left: 30.0,
                  right: 30.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2 - MediaQuery.of(context).size.width/7,
                    child: OutlineButton.icon(
                      icon: Icon(FlutterIcons.cross_ent),
                      label: Text('Clear'),
                      color: primaryMain,
                      textColor: Colors.grey.shade500,
                      highlightedBorderColor: primaryMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () => setState(() => filter = false),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2 - MediaQuery.of(context).size.width/7,
                    child: OutlineButton.icon(
                      icon: Icon(FlutterIcons.ios_options_ion),
                      label: Text('Filter'),
                      color: primaryMain,
                      textColor: primaryMain,
                      highlightedBorderColor: primaryMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () => showAction(),
                    ),
                  ),
                ],
              ),
            ),
          ) : Container(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom:15.0,
                  left: 30.0,
                  right: 30.0
              ),
              child: OutlineButton.icon(
                icon: Icon(FlutterIcons.ios_options_ion),
                label: Text('Filter'),
                color: primaryMain,
                textColor: primaryMain,
                highlightedBorderColor: primaryMain,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                onPressed: () => showAction(),
              ),
            ),
          ) : Container(
            margin:
            EdgeInsets.only(top: 5, bottom: 0),
            child: OrdersBox(
              order: filter ? filtered[index - 1 ] : orders[index - 1],
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

