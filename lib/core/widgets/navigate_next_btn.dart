import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';

import '../../app/theme.dart';
import '../../features/localization/presentation/bloc/language_bloc.dart';
import '../utils/size_config.dart';

class NavigateNextButton extends StatelessWidget {
  const NavigateNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, language) {},
        buildWhen: (prev, curr) =>
            prev.selectedLanguage != curr.selectedLanguage,
        builder: (context, language) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(top: sh! * 0.12, right: 0),
              // top: (sh! * 0.12),
              //  right: 0,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                            padding: language.selectedLanguage.value ==
                                    Language.english.value
                                ? const EdgeInsets.only(
                                    right: 10,
                                  )
                                : const EdgeInsets.only(
                                    left: 10,
                                  ),
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Center(
                                  child: Icon(
                                Icons.navigate_next,
                                color: appPrimaryColor,
                                size: 20,

                                //  onPressed: () => ,
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
        });
  }
}
