import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/ProductCard.dart';
import 'package:customerappgrihasti/components/colorLoader.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:customerappgrihasti/views/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  List<Products> list;
  bool loading;
  bool error;

  @override
  void initState() {
    super.initState();
    list = [];
    loading = true;
    error = false;
  }


  void load(data) {
    print(data);
    if(loading) {
      Firestore.instance.collection('products').where(
          'categoryId', isEqualTo: data['id']).orderBy('Sold', descending: true).limit(30).getDocuments().then((value) {
        if (value.documents.length == 0) {
          setState(() {
            error = true;
            loading = false;
          });
        } else {
          List<DocumentSnapshot> stream = value.documents;
          List<Products> temp = [];
          List<int> prices = [];
          List<String> variety = [];
          stream.forEach((element) {
            prices = [];
            variety = [];
            element.data['Variety'].forEach((variey) {
              prices.add(variey['price']);
              variety.add(variey['name']);
            });
            temp.add(Products(
                element.documentID,
                element.data['Name'],
                element.data['Desc'],
                prices,
                element.data['Pic'],
                element.data['Hash'],
                element.data['categoryParent'],
                variety,
                element.data['categoryId']));
          });
          setState(() {
            list = temp;
            loading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = ModalRoute
        .of(context)
        .settings
        .arguments;
    load(data['data']);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
          child: Builder(
            builder: (context) =>
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Hero(
                    child: IconButton(
                      icon: Icon(
                        FlutterIcons.search1_ant, color: Colors.black38,),
                      onPressed: () {
                        Provider.of<Search>(context).search('');
                        Navigator.of(context).push(
                            new PageRouteBuilder(
                                transitionDuration: Duration(microseconds: 250),
                                transitionsBuilder: (BuildContext context,
                                    Animation<double> animation, Animation<
                                        double> secAnimation, Widget child) {
                                  print(animation);
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                pageBuilder: (BuildContext context, Animation<
                                    double> animation, Animation<
                                    double> secAnimation) {
                                  return SearchPage();
                                }
                            )
                        );
                      },
                    ),
                    tag: 'Search',
                  ),
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
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Calli2',
                              )
                          ),
                          Text(
                              'rihasti',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.13,
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
                        icon: FlutterBadge(
                          itemCount: Provider
                              .of<CartItem>(context)
                              .len,
                          badgeColor: Colors.greenAccent,
                          icon: Icon(FlutterIcons.cart_evi, size: 35,
                            color: Colors.black38,),
                          badgeTextColor: Colors.black38,
                          contentPadding: EdgeInsets.all(7),
                        ),
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/cart'),
                      ),
                      tag: 'Cart',
                    )
                  ],
                ),
          ),
          preferredSize: Size.fromHeight(80.0)
      ),
      body: loading ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/loading.svg',
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
            ),
            Text(
              'Loading',
              style: CupertinoTheme
                  .of(context)
                  .textTheme
                  .navLargeTitleTextStyle,
            ),
            ColorLoader4()
          ],
        ),
      ) : error ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              'assets/svg/error.svg',
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
            ),
            Text(
              'Opps! some error occured\n Comeback later',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                  color: Colors.red
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ) : Container(
          child: ListView.builder(
              itemCount: list.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Text(
                    data['data']['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: ScreenUtil().setSp(35)
                    ),
                    textAlign: TextAlign.left,
                  );
                }
                else {
                  return ProductCard(
                    product: list[index - 1],
                  );
                }
              }
          )
      ),
    );
  }

}