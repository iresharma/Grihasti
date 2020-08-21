import 'package:customerappgrihasti/Services/filterFirebaseData.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/OfferBox.dart';
import 'package:customerappgrihasti/components/ProductCard.dart';
import 'package:customerappgrihasti/components/feelingBox.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:customerappgrihasti/views/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HOme extends StatefulWidget {
  @override
  _HOmeState createState() => _HOmeState();
}

class _HOmeState extends State<HOme> {
  TextEditingController _controller = new TextEditingController();
  bool Topp;
  bool Offers;
  bool Hot;
  bool Prevv;
  int len;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Topp = true;
    Offers = false;
    Hot = false;
    Prevv = false;
    len = Top.length + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FlutterIcons.location_evi,
                    color: primaryMain,
                    size: 30,
                  ),
                  Text(
                    Location,
                    style: TextStyle(color: primaryMain, fontSize: 17),
                  ),
                ],
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<Search>(context).search('');
                    Navigator.of(context).push(
                      new PageRouteBuilder(
                          transitionDuration: Duration(microseconds: 250),
                          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {
                            print(animation);
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
                            return SearchPage();
                          }
                      )
                    );
                  },
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(FlutterIcons.search1_ant),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'Search...'
                    ),
                    enabled: false,
                    controller: _controller,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.grey.shade100,
          height: MediaQuery.of(context).size.height - 252,
          child: ListView.builder(
            primary: true,
            itemCount: len,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      padding: EdgeInsets.all(0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return OfferBox(
                            '500 off.',
                            index,
                            'Some more information, probably long',
                          );
                        },
                      ),
                    ),
                    if (orders.length != 0) ...{
                      FeelingBox(
                        text: 'Happiness is on it\'s way',
                        asset: 'assets/svg/deliver.svg',
                        redirect: 'Shop now',
                      )
                    } else if (Provider.of<CartItem>(context).len == 0) ...{
                      FeelingBox(
                        text: 'It feels very lonely here',
                        asset: 'assets/svg/emptyCart.svg',
                        redirect: 'Shop now',
                      )
                    } else ...{
                      FeelingBox(
                        text: 'Things are ready to be launched',
                        asset: 'assets/svg/filledCart.svg',
                        redirect: 'Place your order',
                      )
                    },
                    Container(
                      margin: EdgeInsets.only(top: 30, bottom: 10),
                      padding: EdgeInsets.all(5),
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey.shade200),
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: FlatButton(
                                child: Text(
                                  'Top products',
                                  style: TextStyle(
                                      fontWeight: Topp
                                          ? FontWeight.w800
                                          : FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(10),
                                      color:
                                          Topp ? primaryMain : Colors.black54),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Topp = true;
                                    Offers = false;
                                    Hot = false;
                                    Prevv = false;
                                    len = Top.length + 1;
                                  });
                                },
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: FlatButton(
                                child: Text(
                                  'Offers',
                                  style: TextStyle(
                                      fontWeight: Offers
                                          ? FontWeight.w800
                                          : FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(10),
                                      color: Offers
                                          ? primaryMain
                                          : Colors.black54),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Topp = false;
                                    Offers = true;
                                    Hot = false;
                                    Prevv = false;
                                    len = Top.length + 1;
                                  });
                                },
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: FlatButton(
                                child: Text(
                                  'Hot Deals',
                                  style: TextStyle(
                                      fontWeight: Hot
                                          ? FontWeight.w800
                                          : FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(10),
                                      color:
                                          Hot ? primaryMain : Colors.black54),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Topp = false;
                                    Offers = false;
                                    Hot = true;
                                    Prevv = false;
                                    len = hotdeals.length + 1;
                                  });
                                },
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: FlatButton(
                                child: Text(
                                  'Previously ordered',
                                  style: TextStyle(
                                      fontWeight: Prevv
                                          ? FontWeight.w800
                                          : FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(10),
                                      color:
                                          Prevv ? primaryMain : Colors.black54),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Topp = false;
                                    Offers = false;
                                    Hot = false;
                                    Prevv = true;
                                    len = Prev.length + 1;
                                  });
                                },
                              )),
                          SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    if (Prev.length == 0 && Prevv) ...{
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Give yourself a gift and place order.',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            FlatButton(
                                child: Text(
                                  'Checkout hot deals',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 15),
                                ),
                                onPressed: () => print('add')),
                            SvgPicture.asset(
                              'assets/svg/empty.svg',
                              width: MediaQuery.of(context).size.width - 100,
                            ),
                          ],
                        ),
                      )
                    }
                  ],
                );
              } else if (Topp)
                return ProductCard(product: Top[index - 1]);
              else if (Hot)
                return ProductCard(product: hotdeals[index - 1]);
//              else if (Offers) return ProductCard(product: Top[index - 1]);
               else return ProductCard(product: Prev[index - 1]);
            },
          ),
        )
      ],
    );
  }
}
