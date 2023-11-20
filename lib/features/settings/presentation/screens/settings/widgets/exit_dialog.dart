import 'package:flutter/material.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showExitDialog(
    {required BuildContext context,
    required Function onCancel,
    required Function onContinue}) {
  showDialog(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;

        return AlertDialog(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.only(top: sh! * 0.1 , ),
            scrollable: true,
            actions: [
              TextButton(
                child: Text(l10n.cancel),
                onPressed: () => onCancel(),
              ),
              TextButton(
                  child: Text(l10n.continueX), onPressed: () => onContinue())
            ],
            content: Container(
              width: sw! * 0.5,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Text(
                l10n.areYouSureYouWantToLogOutFromSpavation,
                style: TextStyles.inter
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ));
      });
}
