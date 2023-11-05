import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:spavation/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:spavation/features/home/presentation/screens/home/home.dart';
import 'package:spavation/features/localization/presentation/bloc/language_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/utils/navigation.dart';
import '../../../../localization/domain/entities/language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AuthenticationBloc _authenticationBloc;
  late LanguageBloc _languageBloc;

  String token = '', language = '';
  bool userExists = false;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    token = Prefs.getString(Prefs.TOKEN) ?? '';

    language = Prefs.getString(Prefs.LANGUAGE) ?? '';
    _languageBloc = BlocProvider.of(context)
      ..add(ChangeLanguage(
          selectedLanguage:
              language == 'en' ? Language.english : Language.arabic));

    log(token);

    if (token != '') {
      _authenticationBloc.add(GetUserEvent(token: token));
    }

    _controller =
        VideoPlayerController.asset("assets/animation/splash-animation.mp4");

    _controller.initialize().then((value) => {
          Timer(const Duration(milliseconds: 20), () {
            setState(() {
              _controller.play();
            });
          }),
          _controller.addListener(() {
            //custom Listner
            setState(() {
              if (!_controller.value.isPlaying &&
                  _controller.value.isInitialized &&
                  (_controller.value.duration == _controller.value.position)) {
                navigateToHome();
                //checking the duration and position every time
                setState(() {});
              }
            });
          })
        });

    super.initState();
  }

  void navigateToHome() {
    if (mounted) {
      Future.delayed(
          const Duration(seconds: 1),
          () => navigateAndRemoveUntil(
              token.isEmpty || !userExists
                  ? const AuthenticationScreen()
                  : const Home(),
              context,
              false));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state.user != null) {
                if (state.user!.isNotEmpty) {
                  setState(() {
                    userExists = true;
                    //  navigateToHome();
                  });
                }
              }
            },
            listenWhen: (prev, curr) => prev.user != curr.user,
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              log(state.user.toString());
              return Center(
                  child: Container(
                      color: Colors.white,
                      height: 300,
                      width: 300,
                      child: VideoPlayer(
                          _controller)) //  SvgPicture.asset(Assets.iconsLogo),
                  );
            }));
  }
}
