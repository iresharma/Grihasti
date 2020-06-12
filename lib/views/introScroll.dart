import 'package:customerappgrihasti/Services/globalVariables.dart';
import 'package:customerappgrihasti/views/login.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

List <Slide> slides = new List();

class IntroScroller extends StatefulWidget {
  @override
  _IntroScrollerState createState() => _IntroScrollerState();
}

class _IntroScrollerState extends State<IntroScroller> {

	void onDonePress() {
		// Do what you want
		Navigator.pushReplacement(
			context,
			MaterialPageRoute(builder: (context) => Login()),
		);
	}

	Widget renderNextBtn() {
		return Icon(
			Icons.navigate_next,
			color: Colors.black,
			size: 35.0,
		);
	}

	Widget renderDoneBtn() {
		return Icon(
			Icons.done,
			color: Colors.black,
		);
	}

	Widget renderSkipBtn() {
		return Icon(
			Icons.skip_next,
			color: Colors.black,
		);
	}

	@override
  void initState() {
    super.initState();
	slides.add(
		new Slide(
			title: "Save Time",
			styleTitle:
			TextStyle(
				color: secondaryMain,
				fontSize: 30.0,
				fontWeight: FontWeight.bold,
				fontFamily: 'RobotoMono'
			),
			widgetDescription: Align(
				alignment: Alignment.bottomCenter,
				child: Text(
					"Time in itself is an important comodity!",
					style: TextStyle(
						color: secondaryMain,
						fontSize: 20.0,
						fontStyle: FontStyle.italic,
						fontFamily: 'Raleway'
					),
				),
			),
			marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
			centerWidget: SizedBox(
				height: 300,
				width: 300,
				child: FlareActor(
					'assets/animation/delivery.flr',
					alignment: Alignment.center,
					fit: BoxFit.contain,
					sizeFromArtboard: true,
					animation: "Animations",
				),
			),
			colorBegin: primaryMain,
			colorEnd: primaryMain,
			directionColorBegin: Alignment.topLeft,
			directionColorEnd: Alignment.bottomRight,
			onCenterItemPress: () {},
		),
	);
	slides.add(
		new Slide(
			title: "Safe and on time Delivery",
			styleTitle:
			TextStyle(
				color: primaryMain,
				fontSize: 30.0,
				fontWeight: FontWeight.bold,
				fontFamily: 'RobotoMono'
			),
			widgetDescription: Align(
				alignment: Alignment.bottomCenter,
				child: Text(
					"Time in itself is an important comodity!",
					style: TextStyle(
						color: primaryMain,
						fontSize: 20.0,
						fontStyle: FontStyle.italic,
						fontFamily: 'Raleway'
					),
				),
			),
			marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
			centerWidget: SizedBox(
				height: 300,
				width: 300,
				child: FlareActor(
					'assets/animation/delivery_scooter.flr',
					alignment: Alignment.center,
					fit: BoxFit.contain,
					sizeFromArtboard: true,
					animation: "run",
				),
			),
			colorBegin: secondaryMain,
			colorEnd: secondaryMain,
			directionColorBegin: Alignment.topLeft,
			directionColorEnd: Alignment.bottomRight,
			onCenterItemPress: () {},
		),
	);
	slides.add(
		new Slide(
			title: "Delivered with ♥️",
			styleTitle:
			TextStyle(
				color: secondaryMain,
				fontSize: 30.0,
				fontWeight: FontWeight.bold,
				fontFamily: 'RobotoMono'
			),
			widgetDescription: Align(
				alignment: Alignment.bottomCenter,
				child: Text(
					"Items are carefully packaged and delivered",
					style: TextStyle(
						color: secondaryMain,
						fontSize: 20.0,
						fontStyle: FontStyle.italic,
						fontFamily: 'Raleway'
					),
				),
			),
			marginDescription: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
			centerWidget: SizedBox(
				height: 300,
				width: 300,
				child: FlareActor(
					'assets/animation/box.flr',
					alignment: Alignment.center,
					fit: BoxFit.contain,
					sizeFromArtboard: true,
					animation: "anim",
				),
			),
			colorBegin: primaryMain,
			colorEnd: primaryMain,
			directionColorBegin: Alignment.topLeft,
			directionColorEnd: Alignment.bottomRight,
			onCenterItemPress: () {},
		),
	);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
		slides: slides,
		renderSkipBtn: this.renderSkipBtn(),
		colorSkipBtn: Color(0x33000000),
		highlightColorSkipBtn: Color(0xff000000),
		renderNextBtn: this.renderNextBtn(),
		renderDoneBtn: this.renderDoneBtn(),
		onDonePress: this.onDonePress,
		colorDoneBtn: Color(0x33000000),
		highlightColorDoneBtn: Color(0xff000000),
		shouldHideStatusBar: true,
		backgroundColorAllSlides: Colors.grey,
	);
  }
}
