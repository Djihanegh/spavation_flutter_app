import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';

import '../../app/theme.dart';
import '../../features/localization/presentation/bloc/language_bloc.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => pop(context),
        child: BlocConsumer<LanguageBloc, LanguageState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                  padding:
                      state.selectedLanguage.value == Language.english.value
                          ? const EdgeInsets.only(right: 10)
                          : const EdgeInsets.only(left: 20),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Center(
                      child: Icon(
                        Icons.navigate_next,
                        color: appPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ));
            }));
  }
}
