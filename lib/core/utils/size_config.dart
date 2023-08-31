import 'package:flutter/material.dart';

MediaQueryData? mediaQueryData;
double? screenWidth;
double? screenHeight;
double? defaultSize;
Orientation? orientation;

void screenSizeInit(BuildContext context) {
  mediaQueryData = MediaQuery.of(context);
  screenWidth = mediaQueryData!.size.width;
  screenHeight = mediaQueryData!.size.height;
  orientation = mediaQueryData!.orientation;
}

double? get sw => screenWidth;

double? get sh => screenHeight;

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = sh!;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = sw!;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getAdaptiveTextSize(dynamic value) {
  double screenHeight = sh!;

  // 720 is medium screen height
  return (value / 720) * screenHeight;
}
