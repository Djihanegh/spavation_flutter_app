import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';
import 'package:spavation/localization.dart';

import '../../app/theme.dart';
import '../../features/localization/presentation/bloc/language_bloc.dart';
import '../utils/size_config.dart';

class NavigateNextButton extends StatelessWidget {
  const NavigateNextButton({super.key, this.topPadding});

  final double? topPadding;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: topPadding ?? sh! * 0.12, right: 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: l10n.localeName == 'en'
                          ? const EdgeInsets.only(
                              right: 20,
                            )
                          : const EdgeInsets.only(
                              left: 20,
                            ),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.transparent),
                        child: const Center(
                            child: Icon(
                          Icons.navigate_next,
                          color: appPrimaryColor,
                          size: 20,
                        )),
                      ))
                ],
              )
            ]),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
