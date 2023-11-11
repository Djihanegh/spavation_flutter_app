import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../app/theme.dart';
import '../../../../../../core/utils/app_styles.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({
    super.key,
    required this.isDisabled,
    required this.isSelected,
    required this.time,
  });

  final bool isDisabled;
  final bool isSelected;
  final String time;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
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
      child: AutoSizeText(
        time,
        style: TextStyles.inter.copyWith(
            color: isSelected
                ? Colors.white
                : isDisabled
                    ? appPrimaryColor.withOpacity(0.3)
                    : appPrimaryColor,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
