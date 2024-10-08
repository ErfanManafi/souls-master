import 'package:flutter/material.dart';

class MyColor {
  static const scaffoldBgColor = LinearGradient(
    colors: [
      Color.fromARGB(255, 15, 15, 15), // Dark gray color

      Color.fromRGBO(150, 141, 87, 1), // Light brown color
    ],
    begin: AlignmentDirectional.bottomCenter,
    end: AlignmentDirectional.topCenter,
    stops: [
      0.2,
      1,
    ], // Adjust these values to control the transition
  );
  static const articleSingleBannerGradient = LinearGradient(
      colors: [Colors.black, Color.fromARGB(0, 0, 0, 0)],
      begin: Alignment.topCenter,
      end: Alignment.center);
  static const posterScreenGradient = LinearGradient(
    colors: [
      Colors.black,
      Colors.transparent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 0.6],
  );
  static const mainScreenPosterGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 0, 0, 0),
      Color.fromARGB(76, 71, 71, 71),
    ],
    begin: AlignmentDirectional.bottomCenter,
    end: AlignmentDirectional.topCenter,
    stops: [
      0.1,
      0.8,
    ], // Adjust these values to control the transition
  );
  static const Color loadingColor = Color.fromARGB(255, 150, 141, 87);
  static const Color appBarBackGround = Colors.transparent;
  static const Color splashScreenBg = Color.fromARGB(255, 10, 10, 10);
  static const Color singlePageatitleContainer = Colors.white;
  static const Color androidBottomNavBarColor = Color.fromARGB(255, 15, 15, 15);
}
