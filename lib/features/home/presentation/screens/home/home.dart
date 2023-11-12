import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/features/home/presentation/screens/home/home_screen.dart';
import 'package:spavation/features/localization/domain/entities/language.dart';
import 'package:spavation/features/localization/presentation/bloc/language_bloc.dart';
import 'package:spavation/features/reservation/presentation/screens/reservation_screen.dart';
import 'package:spavation/features/settings/presentation/screens/settings/settings_screen.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../../localization/presentation/bloc/language_bloc.dart';
import 'widgets/bottom_nav_bar_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onPressed(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  List<Widget> pages = const [
    HomeScreen(),
    ReservationScreen(),
    SettingsScreen()
  ];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);

    return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
              !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: buildNavigator(),
          bottomNavigationBar: _navBarWidget(),
        ));
  }

  buildNavigator() {
    return Navigator(
      key: _navigatorKeys[_selectedIndex],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (_) => pages.elementAt(_selectedIndex));
      },
    );
  }

  Widget _navBarWidget() {
    final l10n = AppLocalizations.of(context)!;
    Language language = context.read<LanguageBloc>().state.selectedLanguage;
    return Container(
        margin: const EdgeInsets.only(top: 0),
        height: 82,
        width: sw!,
        color: Colors.transparent,
        child: Stack(alignment: Alignment.center, children: [

          Container(
              height: 82,
              width: sw!,
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                height: 80,
                width: sw!,
                color: appPrimaryColor,
              )),

          if (_selectedIndex == 0 && language.value == Language.english.value)
            Positioned(
                top: -20,
                bottom: 10,
                left: sw! / 11.5,
                child: Container(
                  height: 80,
                  width: sw! * 0.2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (_selectedIndex == 2 && language.value == Language.values[1].value)
            Positioned(
                top: -20,
                bottom: 10,
                left: sw! / 11.5,
                child: Container(
                  height: 80,
                  width: sw! * 0.2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (_selectedIndex == 1 && language.value == Language.english.value)
            Positioned(
                top: -20,
                bottom: 10,
                left: sw! / 2.75,
                child: Container(
                  height: 80,
                  width: sw! * 0.24,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (_selectedIndex == 1 && language.value == Language.values[1].value)
            Positioned(
                top: -20,
                bottom: 10,
                // right: sw! / 0.8,
                left: sw! / 3,
                child: Container(
                  height: 80,
                  width: sw! * 0.24,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (_selectedIndex == 2 && language.value == Language.english.value)
            Positioned(
                top: -20,
                bottom: 15,
                right: sw! / 9,
                child: Container(
                  height: 80,
                  width: sw! * 0.2,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          if (_selectedIndex == 0 && language.value == Language.values[1].value)
            Positioned(
                top: -20,
                bottom: 10,
                right: sw! / 8.3,
                // left: sw! / ,
                child: Container(
                  height: 80,
                  width: sw! * 0.25,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomNavBarItem(
                  icon: Assets.iconsLogo,
                  title: l10n.home,
                  onPressed: () => _onPressed(0),
                  index: 0,
                  navBarIndex: _selectedIndex,
                ),
                BottomNavBarItem(
                  icon: Assets.iconsList,
                  title: l10n.reservations,
                  onPressed: () => _onPressed(1),
                  index: 1,
                  navBarIndex: _selectedIndex,
                ),
                BottomNavBarItem(
                  icon: Assets.iconsSettingsIcon,
                  title: l10n.settings,
                  onPressed: () => _onPressed(2),
                  index: 2,
                  navBarIndex: _selectedIndex,
                ),
              ]),
        ]));
  }
}
