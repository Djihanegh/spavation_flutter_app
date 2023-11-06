import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/number_symbols_data.dart';
import '../../../../../app/theme.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/endpoint.dart';
import '../../../../../core/utils/typedef.dart';
import '../../../../salons/presentation/bloc/salon_bloc.dart';

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
    return BlocConsumer<SalonBloc, SalonState>(
        listener: (context, state) {},
        listenWhen: (prev, curr) => prev.categoryId != curr.categoryId,
        //   buildWhen: (prev, curr) => prev.categoryId != curr.categoryId,
        builder: (context, state) {
          log(state.categoryId.toString());
          log(int.parse(categoryId).toString());
          return GestureDetector(
              onTap: () {
                DataMap query =
                    Map.of(context.read<SalonBloc>().state.filterOptions ?? {});
                query['category_id'] = categoryId;

                context.read<SalonBloc>().add(GetSalonsEvent(query));
              },
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 10,
                  ),
                  child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 5,
                        top: 5,
                      ),
                      decoration: BoxDecoration(
                          color: state.categoryId == int.parse(categoryId) &&
                                  state.applyFilter
                              ? appPrimaryColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(5)),
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
                              errorBuilder: ((context, error, stackTrace) =>
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundColor: color,
                                      child: const Icon(Icons.error,
                                          color: Colors.black))),
                            ),
                          ),
                          AutoSizeText(
                            title,
                            style: TextStyles.inter
                                .copyWith(color: appPrimaryColor, fontSize: 15),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))));
        });
  }
}
