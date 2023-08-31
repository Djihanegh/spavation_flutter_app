import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';

import '../../../../core/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        body: Stack(
      fit: StackFit.loose,
      children: [
        Container(
          height: sh! * 0.3,
          width: sw! * 0.3,
          decoration: BoxDecoration(
              color: appPrimaryColor.withOpacity(0.35),
              borderRadius: appCircular),
        ),
        Container(
          height: sh! * 0.25,
          decoration: BoxDecoration(
              boxShadow: boxShadow,
              color: appPrimaryColor,
              borderRadius: appBottomCircularRadius(30)),
        ),
      ],
    ));
  }
}
