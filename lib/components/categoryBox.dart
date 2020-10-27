import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/components/colorCircleLoader.dart';
import 'package:customerappgrihasti/models/Category.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
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
      height = docs.length > 3 ? docs.length/3 * 150.0 - 150 : 150.0;
      animate = !animate;
    });
    print(docs);
    print(height);
  }

  @override
  Widget build(BuildContext context) {
    loader();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ExpandablePanel(
            header: Text(
                widget.cat.name,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold
                ),
            ),
            hasIcon: true,
            collapsed: Text('Click to view all ${docs.length} subcategories'),
            expanded: Container(
              height: docs.length > 1 ? (docs.length/3 - 1).round() * 190.0 : 190,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20
                  ),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed('/list', arguments: {
                        'data': docs[index].data
                      }),
                      child: Column(
                        children: [
                          SizedBox(
                            height: ScreenUtil().setSp(60),
                            child: Image.network(docs[index].data['icon']),
                          ),
                          SizedBox(height: 10,),
                          Text(
                              docs[index].data['name'],
                              overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
