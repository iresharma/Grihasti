import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';



class ProductPageOfferBox extends StatefulWidget {

	final Color begin;
	final Color end;
	final String offerText;
	final String finePrint;
	final Icon icon;

  	const ProductPageOfferBox({Key key, this.begin, this.end, this.offerText, this.finePrint, this.icon}) : super(key: key);

  @override
  _ProductPageOfferBoxState createState() => _ProductPageOfferBoxState();
}

class _ProductPageOfferBoxState extends State<ProductPageOfferBox> {
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
		  child: Center(
			  child: Row(
				  crossAxisAlignment: CrossAxisAlignment.center,
				  mainAxisAlignment: MainAxisAlignment.spaceBetween,
				  children: <Widget>[
					  Flexible(
						  child: Align(
							  alignment: Alignment.centerLeft,
							  child: Column(
								  mainAxisAlignment: MainAxisAlignment.center,
								  crossAxisAlignment: CrossAxisAlignment.start,
								  children: <Widget>[
									  Text(
										  widget.offerText,
										  style: TextStyle(
											  fontSize: 20,
											  color: Colors.white,
											  fontWeight: FontWeight.bold
										  ),
									  ),
									  Text(
										  widget.finePrint,
										  style: TextStyle(
											  fontSize: widget.offerText.length < 10 ? (widget.offerText.length % 20).toDouble() : 10,
											  color: Colors.white,
											  fontWeight: FontWeight.bold,
										  ),
										  textAlign: TextAlign.left,
									  )
								  ],
							  )
						  ),
					  ),
					  widget.icon
				  ],
			  ),
		  ),
	  );
  }
}

