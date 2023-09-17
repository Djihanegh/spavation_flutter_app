import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/features/authentication/presentation/screens/authentication_screen.dart';
import 'package:spavation/features/home/presentation/screens/home/home.dart';
import 'package:spavation/features/home/presentation/screens/home/home_screen.dart';
import 'package:video_player/video_player.dart';

import '../utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;

  String token = '';

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    token = Prefs.getString(Prefs.TOKEN) ?? '';

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
                log('IT ENDSSS');
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
    log('NAVIGATING');
     if (mounted) {
    Future.delayed(
        const Duration(seconds: 3),
        () => navigateAndRemoveUntil(
            token.isEmpty ? const AuthenticationScreen() : const Home(),
            context));
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
      body: Center(
          child: Container(
              color: Colors.white,
              height: 300,
              width: 300,
              child: VideoPlayer(
                  _controller)) //  SvgPicture.asset(Assets.iconsLogo),
          ),
    );
  }
}
