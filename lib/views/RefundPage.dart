import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/components/appBar.dart';
import 'package:customerappgrihasti/models/Cart.dart';
import 'package:customerappgrihasti/models/Order.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

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
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  String loadText = 'Compressing';
  bool loading = false;
  String product = '';
  String reason = '';

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://grihasti-nirmal.appspot.com/');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        appBar: CustAppBar(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'Refund Request',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navLargeTitleTextStyle,
                          ),
                        ),
                        Theme(
                          data: ThemeData(canvasColor: Colors.white),
                          child: DropDown(
                            hint: Text('Select a reason'),
                            items: [
                              'Stale items/Expired items',
                              'Wanted to order something else',
                              'Changed my mind',
                              'Got a better deal'
                            ],
                            onChanged: (value) =>
                                setState(() => reason = value),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70, vertical: 30),
                          child: TextField(
                            maxLines: 6,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade200,
                                hintText: "State your reason to return/refund"
                            ),
                            onChanged: (value) =>
                                setState(() => explain = value),
                          ),
                        ),
                        Theme(
                          data: ThemeData(canvasColor: Colors.white),
                          child: DropDown(
                            hint: Text('Select a specific product (optional)'),
                            items: List.generate(
                                widget.order.items.length,
                                (index) =>
                                    '${widget.order.items[index].Name} ( ₹ ${widget.order.items[index].price})'),
                            onChanged: (value) =>
                                setState(() => product = value),
                          ),
                        ),
                        Container(
                          height: images.length + 1 > 3
                              ? (150.0 * ((images.length + 1) / 3).floor()) +
                                  150
                              : 150,
                          child: GridView.builder(
                              padding: EdgeInsets.all(15),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: images.length + 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: ScreenUtil().setSp(5),
                                crossAxisSpacing: ScreenUtil().setSp(5),
                              ),
                              itemBuilder: (context, index) {
                                if (index == 0)
                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey.shade300,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width / 3 -
                                            ScreenUtil().setSp(5) * 2,
                                    child: DottedBorder(
                                      radius: Radius.circular(10),
                                      color: Colors.grey.shade500,
                                      strokeWidth: 3,
                                      dashPattern: [6, 4],
                                      borderType: BorderType.RRect,
                                      child: GestureDetector(
                                        onTap: () => showAction(),
                                        child: Container(
                                          height: 150,
                                          color: Colors.transparent,
                                          child: Center(
                                            child: Icon(
                                              FlutterIcons.camera_fea,
                                              color: Colors.grey.shade600,
                                              size: ScreenUtil().setSp(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                else
                                  return CupertinoContextMenu(actions: <
                                      CupertinoContextMenuAction>[
                                    CupertinoContextMenuAction(
                                      child: Row(
                                        children: [
                                          Icon(FlutterIcons.crop_fea),
                                          SizedBox(
                                            width: ScreenUtil().setSp(15),
                                          ),
                                          Text('Crop')
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                      ),
                                    ),
                                    CupertinoContextMenuAction(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            FlutterIcons.delete_fea,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setSp(15),
                                          ),
                                          Text(
                                            'Remove',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        setState(
                                            () => images.removeAt(index - 1));
                                      },
                                    )
                                  ], child: Image.file(images[index - 1]));
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                FlutterIcons.info_fea,
                                size: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Long press on the images to see more options',
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(10)),
                              )
                            ],
                          ),
                        ),
                        FlatButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.green,
                            textColor: Colors.white,
                            onPressed: () async {
                              List<String> links = await upload();
                              Firestore.instance.collection('refunds').document(widget.order.id).setData({
                                'links': links,
                                'reasonExp': explain,
                                'product': product,
                                'reason': reason
                              });
                            },
                            icon: Icon(
                              FlutterIcons.assignment_return_mdi,
                              color: Colors.white,
                            ),
                            label: Text('Send request'))
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (loading) ...{
              Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        Text(
                          loadText,
                          style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ))
            }
          ],
        ));
  }

  VoidCallback showAction() {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Center(
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.photo_camera),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Capture Photo')
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  onPressed: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      setState(() {
                        images.add(File(pickedFile.path));
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'No photo Selected');
                    }
                  },
                ),
                CupertinoActionSheetAction(
                  child: Center(
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.collections),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Select Photo')
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                  onPressed: () async {
                    final pickedFile =
                        await picker.getImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
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
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ));
  }

  Future<List<String>> upload() async {
    if (images.length == 0) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text('Upload images of products'),
      ));
    } else {
      setState(() {
        loading = true;
      });
      setState(() {
        loadText = 'Uploading';
      });
      final List<StorageReference> ref = List.generate(
          images.length,
          (index) => _storage
              .ref()
              .child('refunds')
              .child('${widget.order.id}')
              .child(path.basename(images[index].path)));
      print('list made');
      List<String> link = [];
      int ind = 0;
      for (StorageReference i in ref) {
        print('Creating task $ind');
        var temp = i.putFile(images[ind]);
        await temp.onComplete;
        link.add(await i.getDownloadURL());
        ind++;
      }
      _key.currentState.showSnackBar(SnackBar(
        content: Text('Upload Complete'),
      ));
      setState(() {
        loading = false;
      });
      print('task ended');
      return link;
    }
  }
}
