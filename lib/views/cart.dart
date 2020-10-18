import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/razorPay.dart';
import 'package:customerappgrihasti/components/CartProduct.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Offers.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:customerappgrihasti/views/Login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool progressing;
  TextEditingController _controller = new TextEditingController();
  List<bool> _selected;
  double offerVal = 0;
  bool offerapp = false;
  bool offerErr = false;
  String offerMessage = '';

  List<Color> colors = [Colors.blue, Colors.teal, Colors.yellow, Colors.green];

  @override
  void initState() {
    super.initState();
    progressing = false;
    _selected = [false, true];
  }

  VoidCallback _showCheckout(coinVal) {
    showModalBottomSheet(
      context: context,
      builder: (context1) => StatefulBuilder(
        builder: (BuildContext context, StateSetter stater) => SingleChildScrollView(
          child: Card(
            elevation: 200,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: 10),
//                                      height: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.height/3 + 100 : MediaQuery.of(context).size.height/3 + 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Checkout',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .navTitleTextStyle,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                        BorderRadius.circular(5)),
                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.all(20),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                              FlutterIcons.search1_ant),
                          floatingLabelBehavior:
                          FloatingLabelBehavior.never,
                          labelText: 'Coupon code',
                          suffixIcon: IconButton(
                            icon: Icon(FlutterIcons.check_ant),
                            onPressed: () {
                              Map<String, dynamic> got = checkOffer(Provider.of<CartItem>(context).totalPrice - coinVal.toInt());
                              stater(() {
                                offerVal = got['offerVal'];
                                offerapp = got['offerapp'] ?? false;
                                offerErr = got['offerErr'] ?? false;
                                offerMessage = got['offerMessage'] ?? '';
                              });
                            },
                          )
                      ),
                      enabled: true,
                      controller: _controller,
                    ),
                  ),
                  if(offerErr)...{
                    Text(
                      offerMessage,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(10),
                          color: Colors.red
                      ),
                    ),
                  },
                  ToggleButtons(
                    children: [
                      Container(
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            4,
                        child: Center(child: Text('COD', style: TextStyle(
                            fontWeight: FontWeight.w400
                        ),)),
                      ),
                      Container(
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            4,
                        child:
                        Center(child: Text('Pay Now')),
                      ),
                    ],
                    isSelected: _selected,
                    selectedBorderColor: secondarySec,
                    highlightColor: secondarySec,
                    fillColor: Colors.yellow.shade50,
                    onPressed: (index) {
                      stater(() {
                        _selected = List.generate(
                            2, (index) => false);
                        _selected[index] = true;
                      });
                      print(_selected);
                    },
                    selectedColor: Colors.black,
                  ),
                  Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Tooltip(
                            height: 40,
                            waitDuration: Duration(microseconds: 1),
                            showDuration: Duration(seconds: 5),
                            message: 'A maximum 20% of the final price can be availed as coin bonus',
                            child: Row(
                              children: [
                                Text(
                                  'Coins Applied',
                                  style: TextStyle(
                                    fontSize:
                                    MediaQuery.of(context).textScaleFactor *
                                        17,
                                  ),
                                ),
                                Icon(FlutterIcons.info_outline_mdi, size: MediaQuery.of(context).textScaleFactor * 17,),
                              ],
                            ),
                          ),
                          Text(
                            '- ₹ $coinVal',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      )
                  ),
                  if(offerapp)...{
                    Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Coupon ${_controller.text}',
                              style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).textScaleFactor *
                                    17,
                              ),
                            ),
                            Text(
                              '- ₹ $offerVal',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                          ],
                        )
                    ),
                  },
                  Divider(thickness: 2,),
                  Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Final Price',
                            style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).textScaleFactor *
                                  17,
                            ),
                          ),
                          Text(
                            '₹ ${Provider.of<CartItem>(context).totalPrice - coinVal.toInt() - offerVal.toInt()}',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          )
                        ],
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width/10,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Checkout', style: TextStyle(color: Colors.white),),
                        color: primaryMain,
                        onPressed: () async {
                          if(_selected[0]) {
                            var uid = Activeuser.Uid;
                            await Firestore.instance.collection('orders').document().setData({
                              'items': Provider.of<CartItem>(context).process,
                              'price': Provider.of<CartItem>(context).totalPrice - coinVal - offerVal,
                              'discount': coinVal + offerVal,
                              'uid': uid,
                              'status': 'ordered',
                              'ordered_on': DateTime.now().microsecondsSinceEpoch,
                              'notificationToken': Noti
                            });
                            Activeuser.coins = Activeuser.coins - coinVal.round();
                            await Firestore.instance.collection('users').document(uid).updateData({
                              'Cart': [],
                              'coins': Activeuser.coins
                            });
                            Provider.of<CartItem>(context).empty();
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                                msg: 'Order placed',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                backgroundColor: Colors.green
                            );
                          }
                          else {
                            await doPayment(RPayOptions(
                                amount: (Provider.of<CartItem>(context).totalPrice - coinVal.round() - offerVal.round()) * 100,
                                name: Activeuser.Name,
                                desc: 'Checkout with ${Provider.of<CartItem>(context).len} item(s)',
                                prefill: {
                                  'email': Activeuser.Email,
                                  'contact': Activeuser.Tel.toString()
                                }
                            ), context1, context, coinVal, 'Cart');
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> checkOffer(int total) {
    List<Offers> offer = offers.where((element) => element.code == _controller.text).toList();
    if(offer.length != 0) {
      Offers apply = offer[0];
      if(total >= apply.minVal) {
        double ferVal = total * (apply.percentage/100) > apply.maxVal ? apply.maxVal * 1.0 : total * (apply.percentage/100);

        return {
          'offerVal': ferVal,
          'offerapp': true
        };
      } else {
        return {
          'offerVal': 0.0,
          'offerMessage': 'The total amount should be more than ₹${apply.minVal} to apply this coupon',
          'offerErr': true
        };
      }
    } else {
      return {
        'offerVal': 0.0,
        'offerErr': false,
        'OfferMessage': 'Invalid coupon'
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    double coinVal = Activeuser.coins > 0 ? (Provider.of<CartItem>(context).totalPrice * 0.2 >= Activeuser.coins ? double.parse(Activeuser.coins.toString()) : Provider.of<CartItem>(context).totalPrice * 0.2) : 0;
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: CustAppBar(),
        body: Builder(
          builder: (context) => Provider.of<CartItem>(context).len == 0
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'It feels lonely here',
                        style: TextStyle(
                          color: primaryMain,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/svg/alone.svg',
                          width: MediaQuery.of(context).size.width - 150,
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Check out hot deals->',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize:
                                MediaQuery.of(context).textScaleFactor * 15,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: Provider.of<CartItem>(context).len + 3,
                  itemBuilder: (context, index) {
                    if (index == Provider.of<CartItem>(context).len + 2) {
                      return Container(
                        margin: EdgeInsets.only(
                            top: 10, left: 50, right: 50, bottom: 0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: primaryMain,
                          child: Center(
                            child: Text(
                              'Checkout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).textScaleFactor * 15,
                              ),
                            ),
                          ),
                          onPressed: () => _showCheckout(coinVal),
                        ),
                      );
                    } else if (index ==
                        Provider.of<CartItem>(context).len + 1) {
                      return Container(
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Final Price',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).textScaleFactor *
                                          15,
                                ),
                              ),
                              Text(
                                '₹ ${Provider.of<CartItem>(context).totalPrice.toString()}',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              )
                            ],
                          ));
                    } else if (index == Provider.of<CartItem>(context).len) {
                      return Container();
                    } else
                      return CartProduct(
                          product:
                              Provider.of<CartItem>(context).cartItem[index]);
                  },
                ),
        ));
  }
}
