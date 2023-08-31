import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spavation/features/home/presentation/screens/home_screen.dart';
import 'package:spavation/generated/assets.dart';

import '../../app/theme.dart';
import '../utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 03),
    );

    controller.forward();
    navigateToHome();
    super.initState();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 05),
        () => navigateAndRemoveUntil(const HomeScreen(), context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryColor,
      body: Center(
        child: SvgPicture.asset(Assets.iconsLogo),
      ),
    );
  }
}
