import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({super.key, required this.status});

  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: paddingAll(5),
      decoration: BoxDecoration(
          color: status ? greenWithOpacity : redWithOpacity,
          border: Border.all(color: status ? greenColor : redColor),
          borderRadius: BorderRadius.circular(10)),
      child: AutoSizeText(
        status ? 'Done' : 'Cancel',
        style: TextStyles.inter
            .copyWith(color: status ? greenColor : redColor, fontSize: 14),
      ),
    );
  }
}
