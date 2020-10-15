import 'dart:io';

import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RefunPage extends StatefulWidget {

  final Order order;

  const RefunPage({Key key, this.order}) : super(key: key);

  @override
  _RefunPageState createState() => _RefunPageState();
}

class _RefunPageState extends State<RefunPage> {

  String dropdownValue = 'Return';
  String explain = '';
  final picker = ImagePicker();
  List<File> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          child: Builder(
            builder: (context) => AppBar(
              backgroundColor: Colors.transparent,
              leading: Hero(
                child: IconButton(
                  icon: Icon(FlutterIcons.ios_arrow_back_ion, color: Colors.black38,),
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
              ),
              actions: <Widget>[
                Hero(
                  child: IconButton(
                    icon: Icon(FlutterIcons.search1_ant,color: Colors.black38,),
                    onPressed: () => print('hi'),
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
          ),
          preferredSize: Size.fromHeight(80.0)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: ScreenUtil().setSp(100),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Order #',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(20),
                                  color: Colors.black
                              ),
                            ),
                            TextSpan(
                              text: '${widget.order.id}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(15),
                                  color: Colors.black
                              ),
                            )
                          ]
                      ),
                    ),
                    Divider(thickness: 2, height: 10,),
                    RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Number of items: ${widget.order.items.length.toString()}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(13)
                                )
                            )
                          ]
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Payment mode: ${widget.order.paymentId == 'COD' ? 'COD' : 'Online (' + widget.order.paymentId + ')'}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(13)
                                )
                            )
                          ]
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Amount: ${widget.order.price}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(13)
                                )
                            )
                          ]
                      ),
                    ),
                  ],
                )
            ),
            Container(
              child: Column(
                children: [
                  Theme(
                    data: ThemeData(
                        canvasColor: Colors.white
                    ),
                    child: DropDown(
                      hint: Text('Select a reason'),
                      items: [
                        'Stale items/Expired items',
                        'Wanted to order something else',
                        'Changed my mind',
                        'Got a better deal'
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextField(
                      maxLines: 6,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          hintText: "State your reason to return/refund"
                      ),
                      onChanged: (value) => setState(() => explain = value),
                    ),
                  ),
                  Theme(
                    data: ThemeData(
                        canvasColor: Colors.white
                    ),
                    child: DropDown(
                      hint: Text('Select a specific product (optional)'),
                      items: List.generate(widget.order.items.length, (index) => '${widget.order.items[index].Name} ( ₹ ${widget.order.items[index].price})'),
                    ),
                  ),
                  Container(
                    height: images.length > 3 ? (150.0 * (images.length/3).floor()) + 150 : 150,
                    child: GridView.builder(
                        padding: EdgeInsets.all(15),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: images.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: ScreenUtil().setSp(5),
                          crossAxisSpacing: ScreenUtil().setSp(5),
                        ),
                        itemBuilder: (context, index) {
                          if(index == 0) return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            width: MediaQuery.of(context).size.width/3 - ScreenUtil().setSp(5) * 2,
                            child: DottedBorder(
                              radius: Radius.circular(10),
                              color: Colors.grey.shade500,
                              strokeWidth: 3,
                              dashPattern: [6, 4],
                              borderType: BorderType.RRect,
                              child: GestureDetector(
                                onTap: () => showCupertinoModalPopup(context: context, builder: (_) => CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                      child: Row(
                                        children: [
                                          Icon(CupertinoIcons.photo_camera),
                                          Text('Capture Photo')
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                      ),
                                      onPressed: () async {
                                        final pickedFile = await picker.getImage(source: ImageSource.camera);
                                        if(pickedFile != null) {
                                          setState(() {
                                            images.add(File(pickedFile.path));
                                          });
                                        } else {
                                          Fluttertoast.showToast(msg: 'No photo Selected');
                                        }
                                      },
                                    ),
                                    CupertinoActionSheetAction(
                                      child: Row(
                                        children: [
                                          Icon(CupertinoIcons.collections),
                                          Text('Select Photo')
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                      ),
                                      onPressed: ()  async {
                                        final pickedFile = await picker.getImage(source: ImageSource.gallery);
                                        if(pickedFile != null) {
                                          setState(() {
                                            images.add(File(pickedFile.path));
                                          });
                                        } else {
                                          Fluttertoast.showToast(msg: 'No photo Selected');
                                        }
                                      },
                                    )
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
                                )),
                                child: Container(
                                  height: 150,
                                  color: Colors.transparent,
                                  child: Center(
                                    child: Icon(FlutterIcons.camera_faw, color: Colors.grey.shade600, size: ScreenUtil().setSp(30),),
                                  ),
                                ),
                              ),
                            ),
                          );
                          else return Image.file(images[index - 1]);
                        }
                    ),
                  ),
                  FlatButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () => print('requested'),
                      icon: Icon(FlutterIcons.assignment_return_mdi, color: Colors.white,),
                      label: Text('Send request')
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

