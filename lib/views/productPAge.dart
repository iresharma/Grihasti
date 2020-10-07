import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/components/carosuel.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  
  int option = 0;
  Products product;
  bool loading, error;
  List<bool> isSelected;
  
  @override
  void initState() {
    super.initState();
    option = 0;
    error = false;
    loading = true;
  }

  void load(String id) {
    if(loading) {
      Firestore.instance.collection('products').document(id).get().then((element) => {
        setState(() {
          List<int> prices = [];
          List<String> variety = [];
          element.data['Variety'].forEach((variey) {
            if(variey['Nstock'] != 0) {
              prices.add(variey['price']);
              variety.add(variey['name']);
            }
          });
          product = Products(
              id:element.documentID,
              Name: element.data['Name'],
              desc: element.data['desc'],
              thumb: element.data['thumb'],
              price: prices,
              pictures: element.data['Pic'],
              hash: element.data['Hash'],
              category: element.data['categoryParent'],
              variety: variety,
              SubCategory: element.data['categoryId']);
        }),
        isSelected = List.generate(product.variety.length, (index) => false),
        isSelected[0] = true,
        loading = false
      }).catchError((onError) => setState(() => error = true));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    load(id);
    return Scaffold(
      appBar: CustAppBar(),
      backgroundColor: Colors.white,
      body: loading ? Container() : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: List.generate(product.pictures.length, (index) => BlurHash(
                    hash: product.hash,
                    image: product.pictures[index],
                  )),
                  dotSize: 5.0,
                  dotSpacing: 5.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.transparent,
                  borderRadius: true,
                )
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.Name,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(25)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5
                        ),
                        child: Text(
                          product.category,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setSp(15)
                          ),
                        ),
                      ),
                    ],
                  ),
                  if(Provider.of<CartItem>(context).count(product.id, product.variety[option]) == 0)...{
                    FlatButton(
                      color: primaryMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: primaryMain)
                      ),
                      child: Text(
                          'Add +',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      onPressed: () => Provider.of<CartItem>(context).addToCart(ProductCart(
                          product.id,
                          product.Name,
                          product.desc,
                          product.price[option],
                          product.thumb,
                          product.hash,
                          1,
                          product.category,
                          product.variety[option],
                          product.pictures
                      )),
                    )
                  } else...{
                    Container(
                      decoration: BoxDecoration(
                          color: primaryMain,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      height: 35,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 5,),
                          Container(
                            height: 27,
                            width: 30,
                            padding: EdgeInsets.all(0),
                            child: MaterialButton(
                              shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
                              child: Text(
                                '-',
                                style: TextStyle(
                                    color: primaryMain,
                                    fontSize: MediaQuery.of(context).textScaleFactor * 27,
                                    fontWeight: FontWeight.w300
                                ),
                                textAlign: TextAlign.center,
                              ),
                              color: Colors.white,
                              textColor: Colors.red,
                              onPressed: () => Provider.of<CartItem>(context).removeFromCart(ProductCart(
                                  product.id,
                                  product.Name,
                                  product.desc,
                                  product.price[option],
                                  product.thumb,
                                  product.hash,
                                  0,
                                  product.category,
                                  product.variety[option],
                                  product.pictures
                              )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              Provider.of<CartItem>(context).count(product.id, product.variety[option]).toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: MediaQuery.of(context).textScaleFactor * 15
                              ),
                            ),
                          ),
                          Container(
                            height: 27,
                            width: 30,
                            padding: EdgeInsets.all(0),
                            child: MaterialButton(
                              shape: CircleBorder(side: BorderSide(width: 0, color: Colors.red, style: BorderStyle.solid)),
                              child: Text(
                                '+',
                                style: TextStyle(
                                    color: primaryMain,
                                    fontSize: ScreenUtil().setSp(27),
                                    fontWeight: FontWeight.w400
                                ),
                                textAlign: TextAlign.center,
                              ),
                              color: Colors.white,
                              textColor: Colors.red,
                              onPressed: () => Provider.of<CartItem>(context).addToCart(ProductCart(
                                  product.id,
                                  product.Name,
                                  product.desc,
                                  product.price[option],
                                  product.thumb,
                                  product.hash,
                                  0,
                                  product.category,
                                  product.variety[option],
                                  product.pictures
                              )),
                            ),
                          ),
                          SizedBox(width: 5,)
                        ],
                      ),
                    )
                  }
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Variety',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                        ),
                      ),
                      ToggleButtons(
                        children: List.generate(product.variety.length, (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5
                          ),
                          child: Text(product.variety[index], style: TextStyle(fontSize: ScreenUtil().setSp(10)),),
                        )),
                        isSelected: isSelected,
                        onPressed: (index) => setState(() {
                          option = index;
                          isSelected = List.generate(product.variety.length, (index) => false);
                          isSelected[index] = true;
                        }),
                      )
                    ],
                  ),
                  Text(
                    '₹${product.price[option].toString()}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Description',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(15),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                product.desc ?? 'No description available',
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



// Provider.of<CartItem>(context).count(product.id, product.variety[option])