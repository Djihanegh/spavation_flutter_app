import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/size_config.dart';
import '../../../../../localization/presentation/bloc/language_bloc.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem(
      {super.key,
      required this.icon,
      required this.name,
      required this.onPressed});

  final String icon;
  final String name;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {},
        buildWhen: (prev, curr) =>
            prev.selectedLanguage != curr.selectedLanguage,
        builder: (context, state) {
          return GestureDetector(
              onTap: () => onPressed(),
              child: Padding(
                  padding: state.selectedLanguage.value ==
                          Language.english.value
                      ? const EdgeInsets.only(left: 20, top: 20, bottom: 10)
                      : const EdgeInsets.only(right: 20, top: 20, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(icon),
                          20.widthXBox,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                name,
                                style: TextStyles.montserrat.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14),
                              ),
                              10.heightXBox,
                              Container(
                                color: Colors.white,
                                height: 1,
                                width: sw! * 0.7,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )));
        });
  }
}
