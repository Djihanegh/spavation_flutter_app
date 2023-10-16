import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/presentation/screens/widgets/salon_error_widget.dart';
import '../bloc/salon_bloc.dart';
import 'widgets/salon_loadig_widget.dart';
import 'widgets/salon_item.dart';

class FilterSalonsScreen extends StatefulWidget {
  const FilterSalonsScreen({
    super.key,
    required this.id,
    required this.lat,
    required this.long,
  });

  final String id;
  final double lat;
  final double long;

  @override
  State<FilterSalonsScreen> createState() => _FilterSalonsScreenState();
}

class _FilterSalonsScreenState extends State<FilterSalonsScreen> {
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
        body: BlocConsumer<SalonBloc, SalonState>(
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
                child = const SalonShimmer();
              }

              if (state.filteredSalons != null) {
                if (state.filteredSalons!.isNotEmpty) {
                  child = Flexible(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 0),
                          itemCount: state.filteredSalons?.length,
                          itemBuilder: (context, index) {
                            SalonModel? salon = state.salons?[index];

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
                          }));
                } else {
                  child = const Center(child: Text('No salon found '));
                }
              } else {
                child = const Center(child: Text('Null'));
              }

              return child!;
            }));
  }
}
