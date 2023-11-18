import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spavation/features/cities/presentation/bloc/cities_bloc.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/core/widgets/error_widget.dart';
import '../../../../core/services/location_service.dart';
import '../../../cities/data/models/cities_model.dart';
import '../bloc/salon_bloc.dart';
import 'widgets/salon_loadig_widget.dart';
import 'widgets/salon_item.dart';

class SalonsScreen extends StatefulWidget {
  const SalonsScreen({super.key, required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  State<SalonsScreen> createState() => _SalonsScreenState();
}

class _SalonsScreenState extends State<SalonsScreen> {
  late SalonBloc _salonBloc;
  Position? currentPosition;

  @override
  void initState() {
    _salonBloc = BlocProvider.of(context);
   // _getCurrentPosition();
    // if (_salonBloc.state.salons == [] || _salonBloc.state.salons == null) {
    // _salonBloc.add(const GetSalonsEvent({}));
    // }
    super.initState();
  }

//
  void _refresh() {
    _salonBloc.add(const GetSalonsEvent({}));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<CityBloc, CityState>(
        listener: (context, cityState) {},
        builder: (context, cityState) {
          return BlocConsumer<SalonBloc, SalonState>(
              listener: (context, state) {},
              listenWhen: (prev, curr) => prev.status != curr.status,
              buildWhen: (prev, curr) =>
                  prev.status != curr.status ||
                  curr.applyFilter != prev.applyFilter,
              builder: (context, state) {
                Widget? child;

                if (state.status == SalonsStatus.failure) {
                  child = CustomErrorWidget(
                    onRefresh: () => _refresh(),
                    errorMessage: state.errorMessage,
                  );
                } else if (state.status == SalonsStatus.initial ||
                    state.status == SalonsStatus.inProgress) {
                  child = const SalonShimmer();
                } else if (state.salons != null) {
                  if (state.salons!.isNotEmpty) {
                    List<SalonModel> salons = state.salons ?? [];

                    for (var i = 0; i < salons.length; i++) {
                      double distanceInMetersA = 0.0;

                      if (currentPosition != null) {
                        if (currentPosition?.latitude != 0.0 &&
                            currentPosition?.longitude != 0.0) {
                          distanceInMetersA = Geolocator.distanceBetween(
                              double.parse(salons[i].latitude),
                              double.parse(salons[i].longitude),
                              currentPosition!.latitude,
                              currentPosition!.longitude);
                          distanceInMetersA = distanceInMetersA / 1000;

                          salons[i].setDistance(distanceInMetersA);
                        }
                      } else {
                        int cityId = state.cityId;
                        if (cityState is CityLoadDataSuccessState) {
                          List<CitiesModel> cities = cityState.cities;
                          if (cities != null) {
                            CitiesModel? selectedCity = cities
                                .firstWhere((element) => element.id == cityId);
                            if (selectedCity != null) {
                              distanceInMetersA = Geolocator.distanceBetween(
                                  double.parse(salons[i].latitude),
                                  double.parse(salons[i].longitude),
                                  double.parse(selectedCity.latitude),
                                  double.parse(selectedCity.longitude));
                              distanceInMetersA = distanceInMetersA / 1000;

                              salons[i].setDistance(distanceInMetersA);
                            }
                          }
                        }
                      }
                    }

                    salons.sort((a, b) => a.distance.compareTo(b.distance));

                    child = Flexible(
                        child:  ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 0),
                            itemCount: salons.length,
                            itemBuilder: (context, index) {
                              SalonModel? salon = salons[index];

                              return SalonItem(
                                taxRate: salon.taxRate,
                                taxNumber: salon.taxNumber,
                                salonId: "${salon.id}",
                                title: salon.name,
                                subtitle: salon.description,
                                rate: salon.rate,
                                distance: "${salon.distance}",
                                image: salon.image,
                                isForFemale: salon.isForFemale,
                                isForMale: salon.isForMale,
                              );
                            }));
                  } else {
                    child = Center(child: Text(l10n.noSalonFound));
                  }
                } else {
                  child = Center(child: Text(l10n.noSalonFound));
                }

                return child;
              });
        });
  }
}
