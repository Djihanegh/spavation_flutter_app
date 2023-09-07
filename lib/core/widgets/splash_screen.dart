import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spavation/features/home/presentation/screens/home/home.dart';
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

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller =
        VideoPlayerController.asset("assets/animation/splash-animation.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(false);
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
        });
      });
    });

    navigateToHome();
    super.initState();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 3),
        () => navigateAndRemoveUntil(const Home(), context));
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
