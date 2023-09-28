import 'package:flutter/material.dart';

const appPrimaryColor = Color(0xFFB6A5CA);
const appLightGrey = Color(0xFFBEBEBE);

final blackWith16Opacity = Colors.black.withOpacity(0.16);
const appDarkBlue = Color(0xFF271C5D);
const appYellowColor = Color(0xFFFFF700);
const appStarGrey = Color(0xFFDADADA);
const headerTextColor = Color(0xFF4754A0);
const dividerColor = Color(0xFFDBDBDB);
const appFilterCoLOR = Color(0xFFA25DB6);
const whiteWithOpacity = Color(0xFFF9F9F9);
const greenColor = Color(0xFF00BF52);
const greenWithOpacity = Color(0xFF98FFBE);
//const redWithOpacity = Color(0xFFFFA8A8);
//const redColor = Color(0xFFFF0000);
const lightWhite = Color(0xFFF0F0F0);
const lightPurple = Color(0xFFDCDCDC);
const borderColor = Color(0xFF707070);

List<Color> purple = const [
  Color(0xFF624695),
  Color(0xFF4754A0),
  Color(0xFFA25DB6),
  Color(0xFF660682),
  Color(0xFF813298)
];

List<Color> grey = const [
  Color(0xFFEEEEEE),
];

List<Color> red = const [
  Color(0xFFFF0000),
  Color(0xFFFFA8A8),
  Color(0xFFDB6989)
];

List<Color> green = const [Color(0xFF00C534)];

appBottomCircularRadius(double value) => BorderRadius.only(
    bottomLeft: Radius.circular(value), bottomRight: Radius.circular(value));

const appCircular = BorderRadius.all(Radius.circular(90));

List<BoxShadow>? boxShadow = [
  BoxShadow(
    color: blackWith16Opacity,
    spreadRadius: 0,
    blurRadius: 6,
    offset: const Offset(0, 3), // 0.5
  ),
];

List<BoxShadow>? boxShadow2 = [
  BoxShadow(
    color: blackWith16Opacity,
    spreadRadius: 0,
    blurRadius: 3,
    offset: const Offset(0, 2), // 0.5
  ),
];

paddingAll(double value) => EdgeInsets.all(value);
