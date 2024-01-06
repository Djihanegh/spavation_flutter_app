import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/app/theme.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:spavation/core/cache/cache.dart';
import 'package:spavation/features/banners/presentation/screens/banners_screen.dart';
import 'package:spavation/features/chat/presentation/screens/chat_screen.dart';
import 'package:spavation/features/cities/presentation/bloc/cities_bloc.dart';
import 'package:spavation/features/cities/presentation/screens/widgets/cities_list.dart';
import 'package:spavation/features/home/presentation/screens/filter/filter_screen.dart';
import 'package:spavation/features/home/presentation/screens/home/widgets/custom_icon.dart';
import '../../../../../core/utils/navigation.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../generated/assets.dart';
import '../../../../categories/presentation/screens/categories_screen.dart';
import '../../../../salons/presentation/bloc/salon_bloc.dart';
import '../../../../salons/presentation/screens/salons_screen.dart';
import 'widgets/search_input.dart';
import 'widgets/show_rating_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SalonBloc _salonBloc;
  late CityBloc _cityBloc;
  Position? currentPosition;
  String countryName = '';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _refresh() {
    // _salonBloc.add( const GetSalonsEvent({}));
  }

  @override
  void initState() {
    _salonBloc = BlocProvider.of(context);
    _cityBloc = BlocProvider.of(context)..add(const GetCitiesEvent());
    String token  = Prefs.getString(Prefs.TOKEN) ?? '';
    //log(token);
  //  Future.delayed(Duration.zero, () => showRatingDialog(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: Colors.white,
          backgroundColor: Colors.red,
          strokeWidth: 4.0,
          onRefresh: () async => _refresh(),
          // Pull from top to show refresh indicator.
          child: SingleChildScrollView(
              child: Stack(children: [
            SizedBox(
                height: sh! / 1.1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: sh! * 0.4,
                              decoration: BoxDecoration(
                                  boxShadow: boxShadow,
                                  color: appPrimaryColor,
                                  borderRadius: appBottomCircularRadius(30)),
                            ),
                            Container(
                              height: sh! * 0.1,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: -10,
                            left: -25,
                            child: Container(
                              height: sh! * 0.17,
                              width: sw! * 0.35,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.35),
                                  borderRadius: appCircular),
                            )),
                        const Positioned(
                            top: 50, left: 20, child: CitiesList()),
                        const Positioned(
                          top: 50,
                          right: 30,
                          child: CustomIcon(
                            icon: Icons.filter_alt,
                            page: FilterScreen(),
                          ),
                        ),
                        const BannerScreen(),
                        Positioned(
                            top: sh! * 0.29,
                            left: 5,
                            right: 5,
                            child: const SearchInput()),
                        CategoriesScreen(
                          lat: currentPosition?.latitude ?? 0,
                          long: currentPosition?.longitude ?? 0,
                        )
                      ],
                    ),
                    SalonsScreen(
                      lat: currentPosition?.latitude ?? 0,
                      long: currentPosition?.longitude ?? 0,
                    ),
                  ],
                )),
            Positioned(
                bottom: 20,
                right: 30,
                child: GestureDetector(
                    onTap: () => navigateToPage(const ChatScreen(), context),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: appCircular,
                          boxShadow: boxShadow3,
                          image: const DecorationImage(
                              image: svg.Svg(
                            Assets.iconsChatBtn,
                          ))),
                    ))),
          ]))),
    );
  }
}
