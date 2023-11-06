import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spavation/core/extensions/sizedBoxExt.dart';
import 'package:spavation/features/salons/presentation/screens/widgets/salon_error_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/endpoint.dart';
import '../../../../core/utils/typedef.dart';

class ReservationItem extends StatelessWidget {
  const ReservationItem({super.key, required this.reservation});

  final DataMap reservation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    List<String> times = [];
    String time = '';
    log(reservation.toString());
    if (reservation['time'] != null && reservation['time'] != '') {
      times = reservation['time'].split("-");

      if (times.isNotEmpty) {
        try {
          time =
              '${int.parse(times[0]) <= 12 ? "${times[0]} ${l10n.am}" : "${times[0]}${l10n.pm}"} -${int.parse(times[1]) <= 12 ? "${times[1]} ${l10n.am}" : "${times[1]} ${l10n.pm}"}';
        } catch (e) {
          time = 'ERROR';
        }
      }
    }

    return Column(
      children: [
        20.heightXBox,
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 30,
            child: reservation['image'] != null
                ? reservation['image'].isNotEmpty
                    ? Image.network(
                        Endpoints.storageUrl + reservation['image'],
                        fit: BoxFit.cover,
                        errorBuilder: ((context, error, stackTrace) =>
                            const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.error, color: Colors.black))),
                      )
                    : const Icon(Icons.error, color: Colors.black)
                : const Icon(Icons.error, color: Colors.black),
          ),
          title: AutoSizeText(
            reservation['name'],
            style: TextStyles.inter.copyWith(
                color: whiteWithOpacity,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
          subtitle: AutoSizeText(
            reservation['description'] ?? '',
            style: TextStyles.inter
                .copyWith(color: whiteWithOpacity, fontSize: 14),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                l10n.price,
                style: TextStyles.inter.copyWith(
                    color: whiteWithOpacity,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              AutoSizeText(
                "${reservation['price']} ${l10n.sr}" ?? '',
                style: TextStyles.inter
                    .copyWith(color: whiteWithOpacity, fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                l10n.date,
                style: TextStyles.inter.copyWith(
                    color: whiteWithOpacity,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              AutoSizeText(
                "${reservation['date']}" ?? '',
                style: TextStyles.inter
                    .copyWith(color: whiteWithOpacity, fontSize: 14),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                l10n.time,
                style: TextStyles.inter.copyWith(
                    color: whiteWithOpacity,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              AutoSizeText(
                time,
                //"${reservation['time']}"
                //${int.parse(reservation['time']) <= 12 ? l10n.am : l10n.pm
                style: TextStyles.inter
                    .copyWith(color: whiteWithOpacity, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
