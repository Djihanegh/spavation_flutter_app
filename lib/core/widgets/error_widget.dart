import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget(
      {super.key, required this.onRefresh, required this.errorMessage});

  final VoidCallback onRefresh;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.heightXBox,
            AutoSizeText(
              errorMessage,
              style:
                  TextStyles.inter.copyWith(color: Colors.black, fontSize: 16),
            ),
            10.heightXBox,
            GestureDetector(
              onTap: () => onRefresh(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    l10n.tryAgain,
                    style: TextStyles.inter.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15),
                  ),
                  5.widthXBox,
                  const Icon(Icons.refresh, color: Colors.black),
                ],
              ),
            )
          ],
        ));
  }
}
