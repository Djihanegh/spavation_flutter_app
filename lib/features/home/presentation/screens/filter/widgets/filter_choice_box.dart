import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';

class FilterChoiceBox extends StatelessWidget {
  const FilterChoiceBox(
      {super.key,
      required this.isSelected,
      required this.title,
      required this.onChanged});

  final bool isSelected;
  final String title;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);

    return GestureDetector(
        onTap: () => onChanged(),
        child: SizedBox(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: appFilterCoLOR)),
              child: Container(
                margin: paddingAll(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? appFilterCoLOR : Colors.white,
                ),
              ),
            ),
            5.widthXBox,
            AutoSizeText(
              title,
              style: TextStyles.inter.copyWith(
                  color: isSelected ? appFilterCoLOR : Colors.black,
                  fontSize: 16),
            ),
          ],
        )));
  }
}
