import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/config.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:spavation/features/banners/presentation/bloc/banner_bloc.dart';
import 'package:spavation/features/categories/presentation/bloc/category_bloc.dart';
import 'package:spavation/features/products/presentation/bloc/product_bloc.dart';
import 'package:spavation/features/salons/presentation/bloc/salon_bloc.dart';
import 'app/app.dart';
import 'core/cache/cache.dart';
import 'core/services/injection_container.dart';
import 'core/utils/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Prefs.load();
  //setupLogging();
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
          BlocProvider<CategoryBloc>(create: (context) => sl<CategoryBloc>()),
          BlocProvider<BannerBloc>(create: (context) => sl<BannerBloc>()),
          BlocProvider<SalonBloc>(create: (context) => sl<SalonBloc>()),
          BlocProvider<ProductBloc>(create: (context) => sl<ProductBloc>()),
        ],
        child: const SpavationApp(
          config: AppConfig(env: AppEnv.dev),
        )));
  });
}
