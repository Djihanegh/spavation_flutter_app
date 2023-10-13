import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/presentation/screens/widgets/salon_error_widget.dart';
import '../../../../app/theme.dart';
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

  @override
  void initState() {
    _salonBloc = BlocProvider.of(context);
    if (_salonBloc.state.salons == [] || _salonBloc.state.salons == null) {
      _salonBloc.add(const GetSalonsEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalonBloc, SalonState>(
        listener: (context, state) {},
        listenWhen: (prev, curr) => prev.status != curr.status,
        buildWhen: (prev, curr) =>
            prev.status != curr.status && curr.action == RequestType.getSalons,
        builder: (context, state) {
          Widget? child;

          if (state.status == FormzSubmissionStatus.failure) {
            child = const SalonErrorWidget();
          }

          if (state.status == FormzSubmissionStatus.initial ||
              state.status == FormzSubmissionStatus.inProgress) {
            child = const SalonShimmer();
          }

          if (state.salons == []) {
            child = const Text('No salon found ');
          }
          if (state.salons != null && state.salons != []) {
            child = Flexible(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                    itemCount: state.salons?.length,
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
          }

          return child!;
        });
  }
}
