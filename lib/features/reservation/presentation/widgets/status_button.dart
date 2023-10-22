import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingAll(5),
      decoration: BoxDecoration(
          color: status == 'active'
              ? greenWithOpacity
              : status == 'pending'
                  ? appYellowColor.withOpacity(0.5)
                  : red[1],
          border: Border.all(
              color: status == 'active'
                  ? greenColor
                  : status == 'pending'
                      ? appYellowColor
                      : red[0]),
          borderRadius: BorderRadius.circular(10)),
      child: AutoSizeText(
        status.toUpperCase(),
        style: TextStyles.inter.copyWith(
            color: status == 'active'
                ? greenColor
                : status == 'pending'
                    ? appYellowColor
                    : red[0],
            fontSize: 14),
      ),
    );
  }
}
