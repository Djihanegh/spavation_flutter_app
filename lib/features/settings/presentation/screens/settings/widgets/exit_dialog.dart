import 'package:flutter/material.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/size_config.dart';

showExitDialog(
    {required BuildContext context,
    required Function onCancel,
    required Function onContinue}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.only(top: sh! * 0.1),
            scrollable: true,
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => onCancel(),
              ),
              TextButton(
                  child: const Text("Continue"), onPressed: () => onContinue())
            ],
            content: Container(
              width: sw! * 0.5,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Are you sure you want to log out from Spavation ?',
                style: TextStyles.inter
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ));
      });
}
