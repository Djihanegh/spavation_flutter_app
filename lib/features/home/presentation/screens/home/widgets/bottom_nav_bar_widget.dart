import 'dart:developer';

import 'package:spavation/app/theme.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/size_config.dart';

class BottomNavBarWidget extends StatefulWidget {
  const BottomNavBarWidget(
      {super.key, required this.child, required this.navBarIndex});

  final Widget child;
  final int navBarIndex;

  @override
  State<BottomNavBarWidget> createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int navBarIndex = 0;

  @override
  void initState() {
    navBarIndex = widget.navBarIndex;
    log('WIDGET INDEX  $navBarIndex');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 0),
        height: 82,
        width: sw!,
        color: Colors.transparent,
        child: Stack(alignment: Alignment.center, children: [
          Container(
              height: 82,
              width: sw!,
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 80,
                width: sw!,
                color: appPrimaryColor,
              )),
          if (navBarIndex == 0)
            Positioned(
                top: -20,
                bottom: 10,
                left: sw! / 11.5,
                child: Container(
                  height: 80,
                  width: sw! * 0.2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (navBarIndex == 1)
            Positioned(
                top: -20,
                bottom: 10,
                left: sw! / 2.75,
                child: Container(
                  height: 80,
                  width: sw! * 0.24,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (navBarIndex == 2)
            Positioned(
                top: -20,
                bottom: 15,
                right: sw! / 9,
                child: Container(
                  height: 80,
                  width: sw! * 0.2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          widget.child,
        ]));
  }
}
