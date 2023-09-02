import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/features/home/presentation/screens/home_screen.dart';
import 'package:spavation/features/reservation/presentation/screens/reservation_screen.dart';
import 'package:spavation/features/settings/presentation/screens/settings_screen.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../core/utils/size_config.dart';
import '../widgets/bottom_nav_bar_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navBarIndex = 0;

  void _onPressed(int value) {
    setState(() {
      navBarIndex = value;
    });
  }

  List<Widget> pages = const [
    HomeScreen(),
    ReservationScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    screenSizeInit(context);

    return Scaffold(
      body: pages.elementAt(navBarIndex),
      bottomNavigationBar: _navBarWidget(),
    );
  }

  Widget _navBarWidget() {
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
          if (navBarIndex == 0)
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
          if (navBarIndex == 1)
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
          if (navBarIndex == 2)
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
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BottomNavBarItem(
                  icon: Assets.iconsLogo,
                  title: 'Home',
                  onPressed: () => _onPressed(0),
                  index: 0,
                  navBarIndex: navBarIndex,
                ),
                BottomNavBarItem(
                  icon: Assets.iconsList,
                  title: 'Reservations',
                  onPressed: () => _onPressed(1),
                  index: 1,
                  navBarIndex: navBarIndex,
                ),
                BottomNavBarItem(
                  icon: Assets.iconsSettingsIcon,
                  title: 'Settings',
                  onPressed: () => _onPressed(2),
                  index: 2,
                  navBarIndex: navBarIndex,
                ),
              ])
        ]));
  }
}
