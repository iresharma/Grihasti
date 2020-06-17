import 'package:flutter/material.dart';

class CategoryBox extends StatefulWidget {

	final Color begin;
	final Color end;
	final String categoryName;
	final MaterialPageRoute route;

  const CategoryBox({Key key, this.begin, this.end, this.categoryName, this.route}) : super(key: key);

  @override
  _CategoryBoxState createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
		height: 100,
		width: MediaQuery.of(context).size.width,
		decoration: BoxDecoration(
			gradient: LinearGradient(
				colors: [widget.begin, widget.end],
				begin: Alignment.topLeft,
				end: Alignment.bottomRight),
			borderRadius: BorderRadius.all(Radius.circular(10))),
		padding: const EdgeInsets.all(16.0),
		child: Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				Flexible(
					child: Align(
						alignment: Alignment(-1, 0),
						child: Text(
							widget.categoryName,
							style: TextStyle(
								fontSize: 22,
								color: Colors.white,
								fontWeight: FontWeight.bold),
						)
					),
				),
				GestureDetector(
					child: Container(
						decoration: BoxDecoration(
							color: Colors.white,
							borderRadius: BorderRadius.all(Radius.circular(24))),
						padding:
						const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
						child: Text(
							'View more',
							style: TextStyle(color: widget.end, fontWeight: FontWeight.bold),
						),
					),
					onTap: () => Navigator.of(context).push(widget.route),
				)
			],
		),
	);;
  }
}
