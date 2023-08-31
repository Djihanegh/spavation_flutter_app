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
        //
        Container(
          height: sh! * 0.25,
          decoration: BoxDecoration(
              boxShadow: boxShadow,
              color: appPrimaryColor,
              borderRadius: appBottomCircularRadius(30)),
        ),
        Positioned(
            top: -10,
            left: -25,
            child: Container(
              height: sh! * 0.17,
              width: sw! * 0.35,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.35),
                  borderRadius: appCircular),
            )),
      ],
    ));
  }
}
