import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/utils/navigation.dart';

import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/endpoint.dart';
import '../../../../salons/presentation/screens/filter_salons_by_category_screen.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.image,
      required this.title,
      required this.color,
      required this.categoryId,
      required this.lat,
      required this.long});

  final String image;
  final String title;
  final Color color;
  final String categoryId;
  final double lat;
  final double long;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          navigateToPage(
              FilterSalonsByCategoryScreen(
                id: categoryId,
                lat: lat,
                long: long,
              ),
              context);
        },
        child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: color,
                  child: Image.network(
                    Endpoints.storageUrl + image,
                    fit: BoxFit.contain,
                    errorBuilder: ((context, error, stackTrace) => CircleAvatar(
                        radius: 30,
                        backgroundColor: color,
                        child: const Icon(Icons.error, color: Colors.black))),
                  ),
                ),
                AutoSizeText(
                  title,
                  style: TextStyles.inter
                      .copyWith(color: appPrimaryColor, fontSize: 15),
                  textAlign: TextAlign.center,
                )
              ],
            )));
  }
}
