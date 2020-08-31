import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryBox extends StatefulWidget {
  final Category cat;

  CategoryBox({this.cat});

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  bool animate;
  double height;
  List<DocumentSnapshot> docs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate = false;
    height = 0;
    docs = [];
  }

  void loader() async {
    print('hi');
    List<DocumentSnapshot> temp = docs.length == 0
        ? await Firestore.instance
            .collection('categories')
            .where('parent', isEqualTo: widget.cat.name)
            .getDocuments()
            .then((value) => value.documents)
        : docs;
    setState(() {
      docs = temp;
      height = docs.length * 50.0;
      animate = !animate;
    });
    print(docs);
    print(height);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            height: animate
                ? MediaQuery.of(context).size.height / 15 + 20 + height
                : MediaQuery.of(context).size.height / 15,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.only(
                right: ScreenUtil().setSp(10),
                left: ScreenUtil().setSp(10),
                top: ScreenUtil().setSp(5),
                bottom: ScreenUtil().setSp(5)),
            padding: EdgeInsets.all(10),
            child: animate
                ? Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.cat.name,
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: ScreenUtil().setSp(20)),
                          ),
                          IconButton(
                            icon: Icon(FlutterIcons.chevron_up_ent),
                            onPressed: () {
                              setState(() {
                                animate = !animate;
                              });
                            },
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Container(
                        height: height,
                        child: GridView.builder(
                            itemCount: docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, crossAxisSpacing: 4),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setSp(70),
                                      child: Image.network(docs[index].data['icon']),
                                    ),
                                    Text(docs[index].data['name'])
                                  ],
                                ),
                                onTap: () => Navigator.of(context).pushNamed('/list', arguments: {
                                  'data': docs[index].data
                                }),
                              );
                            }),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.cat.name,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                      IconButton(
                        icon: Icon(FlutterIcons.chevron_down_ent),
                        onPressed: () => loader(),
                      )
                    ],
                  )),
      ),
    );
  }
}
