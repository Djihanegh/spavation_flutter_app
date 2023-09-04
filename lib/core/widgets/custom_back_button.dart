import 'package:flutter/material.dart';

import '../../app/theme.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          height: 20,
          width: 20,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Center(
              child: IconButton(
            splashRadius: 10,
            iconSize: 20,
            padding: paddingAll(0),
            icon: const Icon(
              Icons.navigate_next,
              color: appPrimaryColor,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          )),
        ));
  }
}
