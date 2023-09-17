import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/utils/navigation.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, required this.page});

  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => navigateToPage(page, context),
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1)),
          child: Padding(
              padding: paddingAll(4),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              )),
        ));
  }
}
