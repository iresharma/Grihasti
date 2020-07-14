import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/razorPay.dart';
import 'package:customerappgrihasti/components/CartProduct.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: Hero(
                child: IconButton(
                    icon: Icon(FlutterIcons.align_left_fea, color: Colors.black38,),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                tag: 'Drawer',
            ),
            elevation: 0,
            flexibleSpace: SafeArea(
              child: Hero(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Text(
                              'G',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: MediaQuery.of(context).size.width * 0.15,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Calli2',
                              )
                          ),
                          Text(
                              'rihasti',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: MediaQuery.of(context).size.width * 0.13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Calli'
                              )
                          )
                      ],
                  ),
                  tag: 'Logo',
              ),
            ),
            actions: <Widget>[
              Hero(
                  child: IconButton(
                      icon: Icon(FlutterIcons.search1_ant,color: Colors.black38,),
                      onPressed: () => print('search'),
                  ),
                  tag: 'Search',
              ),
              Hero(
                  child: IconButton(
                      icon: FlutterBadge(
                          itemCount: Provider.of<CartItem>(context).len,
                          badgeColor: Colors.greenAccent,
                          icon: Icon(FlutterIcons.cart_evi, size: 35, color: Colors.black38,),
                          badgeTextColor: Colors.black38,
                          contentPadding: EdgeInsets.all(7),
                      ),
                      onPressed: () => Navigator.of(context).pushNamed('/cart'),
                  ),
                  tag: 'Cart',
              )
            ],
          ),
          preferredSize: Size.fromHeight(80.0)
      ),
      body: Provider.of<CartItem>(context).len == 0 ? Container(
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
                              fontSize: 20
                          ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                  )
              ],
          ),
      ) : ListView.builder(
          itemCount: Provider.of<CartItem>(context).len + 2,
          itemBuilder: (context, index) {
              if(index == Provider.of<CartItem>(context).len + 1) {
                  return Container(
                      margin: EdgeInsets.only(
                          top: 10,
                          left: 50,
                          right: 50,
                          bottom: 0
                      ),
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
                                      fontSize: 20
                                  ),
                              ),
                          ),
                          onPressed: () => showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                  return AlertDialog(
                                      title: Text('Select your payment method'),
                                      content: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.all(20),
                                          child: Text(
                                              'Your bill amount is ${Provider.of<CartItem>(context).totalPrice}, select if you want COD or online payment'
                                          ),
                                      ),
                                      actions: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                  FlatButton(
                                                      child: Text('COD'),
                                                      onPressed: () async {
                                                          var uid = await FirebaseAuth.instance.currentUser().then((value) => value.uid);
                                                          await Firestore.instance.collection('orders').document().setData({
                                                              'items': Provider.of<CartItem>(context).process,
                                                              'price': Provider.of<CartItem>(context).totalPrice,
                                                              'uid': uid
                                                          });
                                                          await Firestore.instance.collection('users').document(uid).updateData({
                                                              'Cart': []
                                                          });
                                                          Provider.of<CartItem>(context).empty();
                                                          Navigator.of(context).pop();
                                                      },
                                                  ),
                                                  FlatButton(
                                                      child: Text('Pay now'),
                                                      onPressed: () => doPayment(RPayOptions(
                                                          Provider.of<CartItem>(context).totalPrice * 100,
                                                          'Iresh',
                                                          'Test one',
                                                          {
                                                              'contact': '+91-8582871444',
                                                              'email': 'iresh.sharma@gmail.com'
                                                          }
                                                      ), context),
                                                  )
                                              ],
                                          )
                                      ],
                                  );
                              }
                          ),
                      ),
                  );
              }
              else if (index == Provider.of<CartItem>(context).len) {
                  return Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                              Text(
                                  'Final Price',
                                  style: TextStyle(
                                      fontSize: 20,
                                  ),
                              ),
                              Text(
                                  Provider.of<CartItem>(context).totalPrice.toString(),
                                  style: TextStyle(
                                      fontSize: 25,
                                  ),
                              )
                          ],
                      )
                  );
              }
              else return CartProduct(product: Provider.of<CartItem>(context).cartItem[index]);
          },
      ),
    );
  }
}
