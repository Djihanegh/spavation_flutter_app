import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/config.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'app/app.dart';
import 'core/services/injection_container.dart';
import 'core/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Bloc.observer = SpavationBlocObserver();

  runApp(const SpavationApp(
    config: AppConfig(env: AppEnv.dev),
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => sl<AuthenticationBloc>()),
        ],
        child: const SpavationApp(
          config: AppConfig(env: AppEnv.dev),
        )));
  });
}
