import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../utils/app_styles.dart';
import '../utils/size_config.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.title,
      required this.color,
      required this.textColor});

  final String title;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: sw! * 0.8,
      padding: paddingAll(10),
      decoration: BoxDecoration(
          color: appFilterCoLOR, borderRadius: BorderRadius.circular(15)),
      child: AutoSizeText(
        title,
        style: TextStyles.inter.copyWith(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    ));
  }
}
