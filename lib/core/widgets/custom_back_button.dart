import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';

import '../../app/theme.dart';
import '../../features/localization/presentation/bloc/language_bloc.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageBloc, LanguageState>(
        listener: (context, state) {},
        buildWhen: (prev, curr) =>
            prev.selectedLanguage != curr.selectedLanguage,
        builder: (context, state) {
          return Padding(
              padding: state.selectedLanguage.value == Language.english.value
                  ? const EdgeInsets.only(right: 10)
                  : const EdgeInsets.only(left: 20),
              child: Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Center(
                    child: IconButton(
                  splashRadius: 10,
                  iconSize: 20,
                  padding: paddingAll(0),
                  icon: const Icon(
                    Icons.navigate_next,
                    color: appPrimaryColor,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                )),
              ));
        });
  }
}
