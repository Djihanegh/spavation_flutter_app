import 'dart:developer';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
import '../../../../core/services/location_service.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../bloc/salon_bloc.dart';
import 'widgets/salon_item.dart';

class FilterSalonsByTextScreen extends StatefulWidget {
  const FilterSalonsByTextScreen({
    super.key,
  });

  @override
  State<FilterSalonsByTextScreen> createState() =>
      _FilterSalonsByTextScreenState();
}

class _FilterSalonsByTextScreenState extends State<FilterSalonsByTextScreen> {
  late SalonBloc _salonBloc;
  Position? currentPosition;

  @override
  void initState() {
    _salonBloc = BlocProvider.of(context);
    _getCurrentPosition();

    super.initState();
  }

  void _getCurrentPosition() async {
    currentPosition = await Location().determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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

                        if (state.status == FormzSubmissionStatus.failure) {
                          child = const SalonErrorWidget();
                        }

                        if (state.status == FormzSubmissionStatus.initial ||
                            state.status == FormzSubmissionStatus.inProgress ||
                            currentPosition == null) {
                          child = const Center(
                              child: LoadingWidget(
                            color: appPrimaryColor,
                          ));
                        }

                        if (state.filteredSalons != null &&
                            state.status != FormzSubmissionStatus.inProgress) {
                          if (state.filteredSalons!.isNotEmpty &&
                              currentPosition != null) {
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
                                      currentPosition!.latitude,
                                      currentPosition!.longitude);
                                  distanceInMeters = distanceInMeters / 1000;
                                  return SalonItem(
                                    taxRate: salon.taxRate,
                                    taxNumber: salon.taxNumber,
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
                            child = Center(child: Text(l10n.noSalonFound));
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
