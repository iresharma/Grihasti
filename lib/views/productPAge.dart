import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/freebaseCloudMessaging.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/Services/razorPay.dart';
import 'package:customerappgrihasti/components/ProductCard.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/components/carosuel.dart';
import 'package:customerappgrihasti/components/colorLoader.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Offers.dart';
import 'package:customerappgrihasti/models/Products.dart';
import 'package:customerappgrihasti/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with AfterLayoutMixin<ProductPage> {
  
  int option = 0;
  Products product;
  bool loading, error;
  List<bool> isSelected;
  List<Products> list = [];
  TextEditingController _controller = new TextEditingController();
  List<bool> _selected;
  double offerVal = 0;
  bool offerapp = false;
  bool offerErr = false;
  String offerMessage = '';
  String subCat;
  
  @override
  void initState() {
    super.initState();
    option = 0;
    error = false;
    loading = true;
    _selected = [false, true];
    subCat = '';
  }

  VoidCallback _showBottom(coinVal) {
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
              height: MediaQuery.of(context).size.height > 1000 ? MediaQuery.of(context).size.height/3 + 100 : MediaQuery.of(context).size.height/3 + 300,
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
                              Map<String, dynamic> got = checkOffer(Provider.of<CartItem>(context).count(product.id, product.variety[option])*product.price[option] - coinVal.toInt());
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
                            '₹ ${Provider.of<CartItem>(context).count(product.id, product.variety[option])*product.price[option] - coinVal.toInt() - offerVal.toInt()}',
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
                              'items': [process(product)],
                              'price': Provider.of<CartItem>(context).count(product.id, product.variety[option])*product.price[option] - coinVal - offerVal,
                              'uid': uid,
                              'status': 'ordered',
                              'ordered_on': DateTime.now().microsecondsSinceEpoch,
                              'notificationToken': Noti,
                              'discount': coinVal + offerVal,
                            });
                            Activeuser.coins = Activeuser.coins - coinVal.round();
                            await Firestore.instance.collection('users').document(uid).updateData({
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
                                amount: ((Provider.of<CartItem>(context).count(product.id, product.variety[option])*product.price[option] - coinVal - offerVal) * 100).round(),
                                name: Activeuser.Name,
                                desc: 'Checkout with ${Provider.of<CartItem>(context).count(product.id, product.variety[option])} item(s)',
                                prefill: {
                                  'email': Activeuser.Email,
                                  'contact': Activeuser.Tel.toString()
                                }
                            ), context1, context, coinVal, 'propage', discount: coinVal + offerVal);
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

  Map<String, dynamic> process(Products element) {
    Map<String, dynamic> temp = {
      'id': element.id,
      'Name': element.Name,
      'desc': element.desc,
      'price': element.price[option],
      'Pic': element.thumb,
      'hash': element.hash,
      'count': Provider.of<CartItem>(context).count(product.id, product.variety[option]),
      'category': element.category,
      'variety': element.variety[option]
    };
    return temp;
  }

  Map<String, dynamic> checkOffer(int total) {
    List<Offers> offer = offers.where((element) => element.code == _controller.text).toList();
    if(offer.length != 0) {
      Offers apply = offer[0];
      if(total >= apply.minVal) {
        double ferVal = total * (apply.percentage/100) > apply.maxVal ? apply.maxVal : total * (apply.percentage/100);

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
  void afterFirstLayout(BuildContext context){
    String id = ModalRoute.of(context).settings.arguments;
    Firestore.instance.collection('products').document(id).get().then((element) =>
    {
      setState(() {
        List<int> prices = [];
        List<String> variety = [];
        element.data['Variety'].forEach((variey) {
          if (variey['Nstock'] != 0) {
            prices.add(variey['price']);
            variety.add(variey['name']);
          }
        });
        subCat = element.data['categoryName'];
        product = Products(
            id: element.documentID,
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
    }).then((value) {
      Firestore.instance.collection('products').where('categoryId', isEqualTo: product.SubCategory).limit(5).getDocuments().then((value) {
        if(value.documents.length != 0) {
          List<DocumentSnapshot> stream = value.documents;
          List<Products> temp = [];

          List<int> prices = [];
          List<String> variety = [];
          stream.forEach((element) {
            if(element.documentID != product.id) {
              prices = [];
              variety = [];
              element.data['Variety'].forEach((variey) {
                prices.add(variey['price']);
                variety.add(variey['name']);
              });
              temp.add(Products(
                  id:element.documentID,
                  Name: element.data['Name'],
                  desc: element.data['desc'],
                  thumb: element.data['thumb'],
                  price: prices,
                  pictures: element.data['Pic'],
                  hash: element.data['Hash'],
                  category: element.data['categoryParent'],
                  variety: variety,
                  SubCategory: element.data['categoryId']));
            }
          });
          setState(() {
            list = temp;
            loading = false;
          });
        } else setState(() {
          loading = false;
        });
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    double coinVal = Activeuser.coins > 0 ? (Provider.of<CartItem>(context).totalPrice * 0.2 >= Activeuser.coins ? double.parse(Activeuser.coins.toString()) : Provider.of<CartItem>(context).totalPrice * 0.2) : 0;
    return Scaffold(
      appBar: CustAppBar(),
      backgroundColor: Colors.white,
      body: loading ? Center(
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
      ) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: List.generate(product.pictures.length, (index) => BlurHash(
                    hash: product.hash,
                    image: product.pictures[index],
                  )),
                  dotSize: 5.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.lightGreenAccent,
                  indicatorBgPadding: 5.0,
                  dotBgColor: Colors.transparent,
                  borderRadius: true,
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.Name,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(25)
                    ),
                  ),
                ),
                Column(children: [
                  Text(
                    'Options',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(15)
                    ),
                  ),
                  if(product.variety.length < 3)...{
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleButtons(
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
                      ),
                    ),
                  } else...{
                    Padding(
                      padding: EdgeInsets.only(
                        top: 0,
                        bottom: 17,
                        right: 17,
                        left: 17
                      ),
                      child: DropdownButton<String>(
                        value: option.toString(),
                        icon: Icon(FlutterIcons.chevron_down_fea, color: primaryMain,),
                        iconSize: ScreenUtil().setSp(15),
                        elevation: 16,
                        style: TextStyle(
                          color: primaryMain,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            print(newValue);
                            option = int.parse(newValue);
                          });
                        },
                        underline: Container(
                          height: 0,
                        ),
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        items: List.generate(product.variety.length, (index) => DropdownMenuItem<String>(value: index.toString(), child: Text(product.variety[index], style: TextStyle(fontSize: ScreenUtil().setSp(17),)))),
                      ),
                    ),
                  }
                ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 20
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  },
                  Text(
                    '₹${product.price[option].toString()}',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
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
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                left: 25,
                right: 25
              ),
              child: FlatButton.icon(
                  onPressed: () {

                  },
                  icon: Icon(FlutterIcons.basket_mco),
                  label: Text('Buy now'),
                  color: primaryMain,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20
              ),
              child: Text(
                product.category,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(15)
                ),
              ),
            ),
            if(list.length == 0)...{
              Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'No similar products found',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.grey
                    ),
                  ),
                ),
              )
            } else...{
              Container(
                height: ScreenUtil.defaultHeight/11 * list.length + 100,
                child: ListView.builder(
                    itemCount: list.length + 1,
                    itemBuilder: (context, index) {
                      if(index == list.length) return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(
                            left: 45,
                            right: 45
                        ),
                        child: OutlineButton.icon(
                          onPressed: () => Navigator.of(context).pushNamed('/list', arguments: {
                            'data': {
                              'id': product.SubCategory,
                              'name': subCat
                            }
                          }),
                          icon: Icon(FlutterIcons.ios_options_ion),
                          label: Text('More'),
                          color: primaryMain,
                          textColor: primaryMain,
                          highlightedBorderColor: primaryMain,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      );
                      else return ProductCard(product: list[index],);
                    }
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}