import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/features/home/presentation/screens/filter/filter_screen.dart';
import 'package:spavation/features/home/presentation/screens/home/widgets/custom_icon.dart';
import 'package:spavation/features/home/presentation/screens/home/widgets/service_item.dart';
import 'package:spavation/generated/assets.dart';

import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../categories/presentation/screens/categories_screen.dart';
import '../../../../categories/presentation/screens/widgets/category_item.dart';
import 'widgets/search_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController sliderController =
      PageController(initialPage: 0, keepPage: false);



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
                      'Riyadh',
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

            Positioned(
                top: sh! * 0.125,
                right: sw! * 0.01,
                child: Container(
                    width: sw! * 0.98,
                    height: sh! * 0.15,
                    // padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: PageView.builder(
                      onPageChanged: (value) {},
                      controller: sliderController,
                      itemCount: 2,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.asset(Assets.imagesSlider1)
                                        .image)),
                            width: sw! * 0.99,
                            height: sh! * 0.15,
                          )),
                    )))),

            Positioned(
                top: sh! * 0.29, left: 5, right: 5, child: const SearchInput()),
           /* Positioned(
                top: sh! * 0.37,
                left: sw! * 0.03,
                right: sw! * 0.03,
                child: Container(
                  width: sw! * 0.935,
                  height: sh! * 0.12,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: boxShadow),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          itemCount: categories.length,
                          itemBuilder: (context, index) => categories[index])),
                ))*/
            CategoriesScreen()
          ],
        ),
        Flexible(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                itemCount: 20,
                itemBuilder: (context, index) => const ServiceItem()))
      ],
    )));
  }

  List<CategoryItem> categories = const [
    CategoryItem(
      color: appPrimaryColor,
      title: 'All',
      image: Assets.imagesSpa2,
    ),
    CategoryItem(
      color: appPrimaryColor,
      title: 'Body care',
      image: Assets.imagesSpa2,
    ),
    CategoryItem(
      color: appPrimaryColor,
      title: 'Hair',
      image: Assets.imagesSpa2,
    ),
    CategoryItem(
      color: appPrimaryColor,
      title: 'Massage',
      image: Assets.imagesSpa2,
    ),
    CategoryItem(
      color: appPrimaryColor,
      title: 'Nails',
      image: Assets.imagesSpa2,
    )
  ];
}
