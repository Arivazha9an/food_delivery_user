import 'package:flutter/material.dart';
import 'package:food_delivery_user/screens/bottom_nav.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      const ContentConfig(
        title: "Fast Delivery",
        description: "Get your food delivered at your doorstep quickly and safely.",
        pathImage: "assets/images/delivery_boy.png",
        backgroundColor: Colors.blueAccent,
        styleTitle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
    slides.add(
      const ContentConfig(
        title: "Variety of Dishes",
        description: "Choose from a wide range of cuisines and delicious dishes.",
        pathImage: "assets/images/variety_food.png",
        backgroundColor: Colors.greenAccent,
        styleTitle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
    slides.add(
      const ContentConfig(
        title: "Easy Payment",
        description: "Pay effortlessly through various payment methods.",
        pathImage: "assets/images/payment.png",
        backgroundColor: Colors.orangeAccent,
        styleTitle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  void onDonePress() {
    // Navigate to another screen
 Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => CustomBottomNavigationBar(), // Replace with the screen you want to navigate to
  ),
);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      listContentConfig: slides,
      onDonePress: onDonePress,
      onSkipPress: onDonePress,
      renderSkipBtn: const Text(
        "Skip",
        style: TextStyle(color: Colors.white),
      ),
      renderNextBtn: const Icon(
        Icons.navigate_next,
        color: Colors.white,
        size: 35,
      ),
      renderDoneBtn: const Text(
        "Done",
        style: TextStyle(color: Colors.white),
      ),
      indicatorConfig: const IndicatorConfig(
        sizeIndicator: 13,
        spaceBetweenIndicator: 5,
        typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition, // Example animation
        colorIndicator: Colors.white,
        colorActiveIndicator: Colors.red, // Active dot color
      ),
      backgroundColorAllTabs: Colors.blue, // Default background color
      
    );
  }
}
