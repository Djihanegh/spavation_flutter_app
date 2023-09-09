import 'package:flutter/material.dart';
import 'package:spavation/core/widgets/splash_screen.dart';

import 'config.dart';

class SpavationApp extends StatelessWidget {
  const SpavationApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
