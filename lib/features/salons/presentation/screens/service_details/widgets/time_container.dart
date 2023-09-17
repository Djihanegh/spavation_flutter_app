import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer(
      {super.key,
      required this.isDisabled,
      required this.isSelected,
      required this.startTime,
      required this.endTime});

  final bool isDisabled;
  final bool isSelected;
  final int startTime;
  final int endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      width: 70,
      decoration: BoxDecoration(
          color: isSelected
              ? appPrimaryColor
              : isDisabled
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected
                  ? appPrimaryColor
                  : isDisabled
                      ? appPrimaryColor.withOpacity(0.3)
                      : appPrimaryColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            '$startTime',
            style: TextStyles.inter.copyWith(
                color: isSelected
                    ? Colors.white
                    : isDisabled
                        ? appPrimaryColor.withOpacity(0.3)
                        : appPrimaryColor,
                fontWeight: FontWeight.w700),
          ),
          AutoSizeText(
            '-',
            style: TextStyles.inter.copyWith(
                color: isSelected
                    ? Colors.white
                    : isDisabled
                        ? appPrimaryColor.withOpacity(0.3)
                        : appPrimaryColor,
                fontWeight: FontWeight.w700),
          ),
          AutoSizeText(
            '$endTime',
            style: TextStyles.inter.copyWith(
                color: isSelected
                    ? Colors.white
                    : isDisabled
                        ? appPrimaryColor.withOpacity(0.3)
                        : appPrimaryColor,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
