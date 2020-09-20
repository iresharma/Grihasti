import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/ProductCard.dart';
import 'package:customerappgrihasti/components/colorLoader.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  List<Products> list;
  Products product;
  bool loading;
  bool error;

  @override
  void initState() {
    super.initState();
    loading = true;
    error = false;
  }

  void loadData(SearchItem item) {
    if(loading) {
      if(item.type == 'category') {
        Firestore.instance.collection('products').where('categoryId', isEqualTo: item.id).limit(30).getDocuments().then((value) {
          if(value.documents.length != 0) {
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
            print('===============');
            print(temp);
            setState(() {
              list = temp;
              loading = false;
            });
          } else setState(() {
            error = true;
            loading = false;
          });
        });
      } else {
        print("=============${item.categoryId}=========");
        Firestore.instance.collection('products').document(item.id).get().then((element) {
          Products temp;
          List<int> prices = [];
          List<String> variety = [];
          prices = [];
          variety = [];
          element.data['Variety'].forEach((variey) {
            prices.add(variey['price']);
            variety.add(variey['name']);
          });
          temp = Products(
              element.documentID,
              element.data['Name'],
              element.data['Desc'],
              prices,
              element.data['Pic'],
              element.data['Hash'],
              element.data['categoryParent'],
              variety,
              element.data['categoryId']
          );
          setState(() {
            product = temp;
          });
        }).catchError((onError) => setState(() {
          error = true;
          loading = false;
        }));
        Firestore.instance.collection('products').where('categoryId', isEqualTo: item.categoryId).limit(30).getDocuments().then((value) {
          if(value.documents.length != 0) {
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
          } else setState(() {
//          error = true;
            loading = false;
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SearchItem data = ModalRoute.of(context).settings.arguments;
    print(data.id);
    print(data.type);
    print(data.categoryId);
    print(data.name);
    loadData(data);
    if(loading) {
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/loading.svg',
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                Text(
                  'Loading',
                  style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                ),
                ColorLoader4()
              ],
            ),
          ),
        );
    } else if(error) {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/error.svg',
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              Text(
                'Opps ! something went wrong',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      if(data.type == 'category') {
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
          body: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: list[index],
              );
            },
          ),
        );
      }
      else {
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
          body: ListView.builder(
            itemCount: list.length + 1,
            itemBuilder: (context, index) {
              if(index == 0) {
                return ProductCard(
                  product: product,
                );
              } else if(index == 1) {
                return Container(
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Similar products you may like',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                      fontSize: ScreenUtil().setSp(15)
                    ),
                  ),
                );
              } else {
                return ProductCard(
                  product: list[index - 1],
                );
              }
            },
          ),
        );
      }
    }
  }
}

