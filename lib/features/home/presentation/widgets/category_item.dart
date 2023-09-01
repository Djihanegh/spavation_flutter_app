import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.image,
      required this.title,
      required this.color});

  final String image;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            AutoSizeText(
              title,
              style: TextStyles.inter.copyWith(color: appPurple, fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
