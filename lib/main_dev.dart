import 'package:flutter/material.dart';
import 'package:spavation/app/config.dart';
import 'app/app.dart';

void main() {
  runApp(const SpavationApp(
    config: AppConfig(env: AppEnv.dev),
  ));
}
