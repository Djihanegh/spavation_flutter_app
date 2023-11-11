import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';

import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../../localization.dart';

class ProductsEmptyWidget extends StatelessWidget {
  const ProductsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomBackButton(),
            ],
          ),
          10.heightXBox,
          Text(l10n.noProductFound)
        ]);
  }
}
