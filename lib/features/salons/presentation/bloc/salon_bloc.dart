import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons_by_category.dart';

import '../../../../core/services/location_service.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../core/utils/typedef.dart';

part 'salon_event.dart';

part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  SalonBloc(
      {required GetSalonsUseCase getSalonsUseCase,
      required GetSalonsByCategoryUseCase getSalonsByCategoryUseCase})
      : _getSalonsUseCase = getSalonsUseCase,
        _getSalonsByCategoryUseCase = getSalonsByCategoryUseCase,
        super(const SalonState()) {
    on<GetSalonsEvent>(_getSalonsHandler);
    on<GetSalonsByCategoryEvent>(_getSalonsByCategoryHandler);
    on<SearchSalonsEvent>(_onSearchSalons);
    on<SelectFilterOptions>(_onSelectFilterOptions);
  }

  final GetSalonsUseCase _getSalonsUseCase;
  final GetSalonsByCategoryUseCase _getSalonsByCategoryUseCase;

  Future<void> _onSelectFilterOptions(
      SelectFilterOptions event, Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(seconds: 1));

    DataMap options = state.filterOptions ?? {};

    if (event.options['gender'] != null) {
      options['gender'] = event.options['gender'];
    }
    if (event.options['open_now'] != null) {
      options['open_now'] = event.options['open_now'];
    }
    if (event.options['near_by'] != null) {
      options['near_by'] = event.options['near_by'];
    }
    emit(state.copyWith(
        status: FormzSubmissionStatus.success, filterOptions: options));
  }

  Future<void> _onSearchSalons(
      SearchSalonsEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(seconds: 1));

    List<SalonModel> salons = state.salons ?? [];

    List<SalonModel> filteredSalons = [];

    DataMap filterOptions = state.filterOptions ?? {};

    Position currentPosition = await Location().determinePosition();

    bool genderIsEmpty = false, nearBy = false, openNow = false;

    log(salons[0].closeDay);
    log(salons[0].openDay);
    log(salons[0].closeTime);
    log(salons[0].openTime);

    DateTime dateTime = DateTime.now();

    if (filterOptions.isNotEmpty) {
      filterOptions.forEach((key, value) {
        if (key == 'gender') {
          if (value == 'men') {
            filterByGender(salons, filteredSalons, 'men', event.text);
          } else if (value == 'women') {
            filterByGender(salons, filteredSalons, 'women', event.text);
          } else if (value == 'both') {
            filterByGender(salons, filteredSalons, 'both', event.text);
          } else {
            genderIsEmpty = true;
          }
        } else if (key == 'open_now') {
          openNow = value;
          if (openNow) {
            for (SalonModel salon in salons) {
              //   DateTime openDay = convertStringToDateTime(salon.openDay);
              DateTime closeDay = convertStringToDateTime(salon.closeDay);

              //   DateTime openTime = convertStringToHourMnSec(salon.openTime);
              DateTime closeTime = convertStringToHourMnSec(salon.closeTime);

              if (dateTime.isBefore(closeDay) &&
                  dateTime.hour < closeTime.hour) {
                if (!filteredSalons.contains(salon)) {
                  filteredSalons.add(salon);
                }
              }
            }
          }
        } else if (key == 'near_by') {
          nearBy = value;

          if (nearBy) {
            for (SalonModel salon in salons) {
              double distanceInMeters = 0.0;
              distanceInMeters = Geolocator.distanceBetween(
                  double.parse(salon.latitude),
                  double.parse(salon.longitude),
                  currentPosition.latitude,
                  currentPosition.longitude);
              distanceInMeters = distanceInMeters / 1000;

              if (distanceInMeters < 10) {
                if (!filteredSalons.contains(salon)) {
                  filteredSalons.add(salon);
                }
              }
            }
          }
        } else {
          filteredSalons = salons;
        }
      });
    }

    if (genderIsEmpty == true && nearBy == false && openNow == false ||
        event.text.isEmpty) {
      filteredSalons = salons;
    }

    emit(state.copyWith(
        status: FormzSubmissionStatus.success, filteredSalons: filteredSalons));
  }

  void filterByGender(List<SalonModel> salons, List<SalonModel> filteredSalons,
      String gender, String text) {
    if (gender == 'men') {
      var isForMale = salons.where((element) => element.isForMale == '1');
      if (isForMale.isNotEmpty) {
        for (SalonModel e in isForMale) {
          if (!filteredSalons.contains(e) && e.name.contains(text)) {
            filteredSalons.add(e);
          }
        }
      }
    } else if (gender == 'women') {
      var isForFemale = salons.where((element) => element.isForFemale == '1');
      if (isForFemale.isNotEmpty) {
        for (SalonModel e in isForFemale) {
          if (!filteredSalons.contains(e) && e.name.contains(text)) {
            filteredSalons.add(e);
          }
        }
      }
    } else if (gender == 'both') {
      filterByGender(salons, filteredSalons, 'men', text);
      filterByGender(salons, filteredSalons, 'women', text);
    }
  }

  Future<void> _getSalonsByCategoryHandler(
      GetSalonsByCategoryEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(seconds: 3));

    final result = await _getSalonsByCategoryUseCase(event.id);

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getSalonsByCategory)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            filteredSalons: r.data,
            action: RequestType.getSalonsByCategory,
            successMessage: '')));
  }

  Future<void> _getSalonsHandler(
      GetSalonsEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _getSalonsUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getSalons)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            salons: r.salons,
            action: RequestType.getSalons,
            successMessage: '')));
  }
}
