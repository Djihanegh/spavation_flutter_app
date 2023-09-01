import 'dart:ui';

import 'package:flutter/material.dart';

const appPrimaryColor = Color(0xFFB6A5CA);
const appLightGrey = Color(0xFFBEBEBE);
final blackWith16Opacity = Colors.black.withOpacity(0.16);
const appPurple = Color(0xFFB6A5CA);
const appDarkBlue = Color(0xFF271C5D);
const appYellowColor = Color(0xFFFFF700);
const appStarGrey = Color(0xFFDADADA);
const headerTextColor = Color(0xFF4754A0);



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

paddingAll(double value) => EdgeInsets.all(value);
