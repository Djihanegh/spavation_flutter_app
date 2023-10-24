import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/presentation/screens/widgets/salon_error_widget.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../bloc/salon_bloc.dart';
import 'widgets/salon_item.dart';

class FilterSalonsByCategoryScreen extends StatefulWidget {
  const FilterSalonsByCategoryScreen({
    super.key,
    required this.id,
    required this.lat,
    required this.long,
  });

  final String id;
  final double lat;
  final double long;

  @override
  State<FilterSalonsByCategoryScreen> createState() =>
      _FilterSalonsByCategoryScreenState();
}

class _FilterSalonsByCategoryScreenState
    extends State<FilterSalonsByCategoryScreen> {
  late SalonBloc _salonBloc;

  @override
  void initState() {
    _salonBloc = BlocProvider.of(context);

    _salonBloc.add(GetSalonsByCategoryEvent(widget.id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        '',
                      ),
                      AutoSizeText(
                        '',
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: CustomBackButton()),
                    ],
                  ),
                  10.heightXBox,
                  BlocConsumer<SalonBloc, SalonState>(
                      listener: (context, state) {},
                      listenWhen: (prev, curr) => prev.status != curr.status,
                      builder: (context, state) {
                        Widget? child;

                        log(state.filteredSalons.toString());

                        if (state.status == FormzSubmissionStatus.failure) {
                          child = const SalonErrorWidget();
                        }

                        if (state.status == FormzSubmissionStatus.initial ||
                            state.status == FormzSubmissionStatus.inProgress) {
                          child = const Center(
                              child: LoadingWidget(
                            color: appPrimaryColor,
                          ));
                        }

                        if (state.filteredSalons != null &&
                            state.status != FormzSubmissionStatus.inProgress) {
                          if (state.filteredSalons!.isNotEmpty) {
                            child = ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                itemCount: state.filteredSalons?.length,
                                itemBuilder: (context, index) {
                                  SalonModel? salon =
                                      state.filteredSalons?[index];

                                  double distanceInMeters = 0.0;
                                  distanceInMeters = Geolocator.distanceBetween(
                                      double.parse(salon!.latitude),
                                      double.parse(salon.longitude),
                                      widget.lat,
                                      widget.long);
                                  distanceInMeters = distanceInMeters / 1000;
                                  return SalonItem(
                                    salonId: "${salon.id}",
                                    title: salon.name,
                                    subtitle: salon.description,
                                    rate: salon.rate,
                                    distance: '$distanceInMeters',
                                    image: salon.image,
                                    isForFemale: salon.isForFemale,
                                    isForMale: salon.isForMale,
                                  );
                                });
                          } else {
                            child =
                                const Center(child: Text('No salon found '));
                          }
                        } else {
                          child = const Center(
                              child: LoadingWidget(
                            color: appPrimaryColor,
                          ));
                        }

                        return child;
                      })
                ])));
  }
}
