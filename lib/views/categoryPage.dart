import 'package:customerappgrihasti/components/categoryBox.dart';
import 'package:flutter/material.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  bool animate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animate = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView.builder(
          itemCount: cat.length,
          itemBuilder: (context, index) => CategoryBox(
            cat: cat[index],
          )),
    );
  }
}

