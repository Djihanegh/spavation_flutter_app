import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:spavation/features/banners/presentation/screens/banners_screen.dart';
import 'package:spavation/features/home/presentation/screens/filter/filter_screen.dart';
import 'package:spavation/features/home/presentation/screens/home/widgets/custom_icon.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/services/location_service.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../categories/presentation/screens/categories_screen.dart';
import '../../../../salons/presentation/bloc/salon_bloc.dart';
import '../../../../salons/presentation/screens/salons_screen.dart';
import 'widgets/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SalonBloc _salonBloc;
  Position? currentPosition;
  String countryName = '';

  @override
  void initState() {
    getCurrentPosition();
    getCountryName();
    _salonBloc = BlocProvider.of(context);
    _salonBloc.add(const GetSalonsEvent());

    super.initState();
  }

  void getCurrentPosition() async {
    currentPosition = await Location().determinePosition();
  }

  void getCountryName() async {
    Uri url = Uri.parse('http://ip-api.com/json');
    Response data = await http.get(url);
    Map<String, dynamic> result = jsonDecode(data.body);

    saveUserAddress(result);
  }

  void saveUserAddress(DataMap result) {
    setState(() {
      countryName = result['country'];
    });
    if (result.isNotEmpty) {
      context
          .read<AuthenticationBloc>()
          .add(UserAddressChanged(address: result));
    }
  }

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          fit: StackFit.loose,
          children: [
            //
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
            Positioned(
                top: 50,
                left: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    AutoSizeText(
                      countryName,
                      style: TextStyles.inter.copyWith(color: Colors.white),
                    ),
                  ],
                )),

            Positioned(
                top: 50,
                right: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomIcon(
                        icon: Icons.map_outlined, page: FilterScreen()),
                    10.widthXBox,
                    const CustomIcon(
                      icon: Icons.filter_alt,
                      page: FilterScreen(),
                    ),
                  ],
                )),

            const BannerScreen(),

            Positioned(
                top: sh! * 0.29, left: 5, right: 5, child: const SearchInput()),

            const CategoriesScreen()
          ],
        ),
        SalonsScreen(
          lat: currentPosition?.latitude ?? 0,
          long: currentPosition?.longitude ?? 0,
        )
      ],
    )));
  }
}
