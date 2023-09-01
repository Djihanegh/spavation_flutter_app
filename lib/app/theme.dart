import 'dart:ui';

import 'package:flutter/material.dart';

const appPrimaryColor = Color(0xFFB6A5CA);
const appLightGrey = Color(0xFFBEBEBE);
const blackWith16Opacity = Color(0xFF000029);

appBottomCircularRadius(double value) => BorderRadius.only(
    bottomLeft: Radius.circular(value), bottomRight: Radius.circular(value));

const appCircular = BorderRadius.all(Radius.circular(90));

List<BoxShadow>? boxShadow = [
  const BoxShadow(
    color: blackWith16Opacity,
    spreadRadius: 0,
    blurRadius: 6,
    offset: Offset(0, 3), // 0.5
  ),
];

paddingAll(double value) => EdgeInsets.all(value);
