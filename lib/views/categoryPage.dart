import 'package:flutter/material.dart';
import 'package:customerappgrihasti/Services/globalVariables.dart';

class categoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: cat.length,
          itemBuilder: (context, index) => Text(cat[index].name)),
    );
  }
}
