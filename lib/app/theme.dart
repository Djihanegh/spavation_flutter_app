import 'dart:ui';

import 'package:flutter/material.dart';

const appPrimaryColor = Color(0xFFB6A5CA);

appBottomCircularRadius(double value) => BorderRadius.only(
    bottomLeft: Radius.circular(value), bottomRight: Radius.circular(value));

const appCircular = BorderRadius.all(Radius.circular(90));

List<BoxShadow>? boxShadow = [
  BoxShadow(
    color: Colors.grey.shade500,
    offset: const Offset(0.0, 1.0), //(x,y)
    blurRadius: 6.0,
  ),
];
