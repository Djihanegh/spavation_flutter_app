import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/features/authentication/presentation/screens/splash/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../features/localization/domain/entities/language.dart';
import '../features/localization/presentation/bloc/language_bloc.dart';
import 'config.dart';

class SpavationApp extends StatelessWidget {
  const SpavationApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    String language = Prefs.getString(Prefs.LANGUAGE) ?? '';
    log('LANGUAGEEEE');
    log(language);
    return BlocProvider(
        create: (context) => LanguageBloc(),
        child:
            BlocBuilder<LanguageBloc, LanguageState>(builder: (context, state) {
          return MaterialApp(
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              locale: state.selectedLanguage.value,
              theme: ThemeData(
                useMaterial3: true,
              ),
              home: Directionality(
                  textDirection: /*language.isNotEmpty
                      ? language == 'en'
                          ? TextDirection.ltr
                          : TextDirection.rtl
                      :*/
                      state.selectedLanguage.value == Language.english.value
                          ? TextDirection.ltr
                          : TextDirection.rtl, // set this property
                  child: const SplashScreen()));
        }));
  }
}
