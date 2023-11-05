import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons_by_category.dart';

import '../../../../core/services/location_service.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/format_date.dart';
import '../../../../core/utils/typedef.dart';

part 'salon_event.dart';

part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  SalonBloc({required GetSalonsUseCase getSalonsUseCase,
    required GetSalonsByCategoryUseCase getSalonsByCategoryUseCase})
      : _getSalonsUseCase = getSalonsUseCase,
        _getSalonsByCategoryUseCase = getSalonsByCategoryUseCase,
        super(const SalonState()) {
    on<GetSalonsEvent>(_getSalonsHandler);
    //  on<GetSalonsByCategoryEvent>(_getSalonsByCategoryHandler);
    on<SearchSalonsEvent>(_onSearchSalons);
    on<SelectFilterOptions>(_onSelectFilterOptions);
    // on<GetSalonsByCityEvent>(_getSalonsByCityHandler);
  }

  final GetSalonsUseCase _getSalonsUseCase;
  final GetSalonsByCategoryUseCase _getSalonsByCategoryUseCase;

  Future<void> _onSelectFilterOptions(SelectFilterOptions event,
      Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    // await Future.delayed(const Duration(milliseconds: 20));

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
    if (event.options['city'] != null) {
      options['city'] = event.options['city'];
    }
    if (event.options['categoryId'] != null) {
      options['categoryId'] = event.options['categoryId'];
    }

    log(options['categoryId'].toString());
    emit(state.copyWith(
      categoryId: int.parse(options['categoryId']),
      status: FormzSubmissionStatus.success,
      filterOptions: options,
    ));
  }

  Future<void> _onSearchSalons(SearchSalonsEvent event,
      Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(seconds: 1));

    List<SalonModel> salons = state.salons ?? [];

    List<SalonModel> filteredSalons = [];

    for (SalonModel e in salons) {
      if (!filteredSalons.contains(e) &&
          e.name.toLowerCase().contains(event.text.toLowerCase())) {
        filteredSalons.add(e);
      }
    }

    /* if (filterOptions.isNotEmpty) {
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
    } */

    emit(state.copyWith(
        status: FormzSubmissionStatus.success, filteredSalons: filteredSalons));
  }

  List<SalonModel> filterByGender(List<SalonModel> salons,
      List<SalonModel> filteredSalons, String gender, String text) {
    if (gender == 'men') {
      if (filteredSalons.isNotEmpty) {
        List<SalonModel> salonsToBeRemoved = [];

        for (SalonModel salon in filteredSalons) {
          if (salon.isForMale != '1' ||
              salon.isForFemale == '1' && salon.isForMale == '1') {
            salonsToBeRemoved.add(salon);
          }
        }
        for (SalonModel salon in salonsToBeRemoved) {
          filteredSalons.remove(salon);
        }
      } else {
        var isForMale = salons.where((element) => element.isForMale == '1');
        if (isForMale.isNotEmpty) {
          for (SalonModel e in isForMale) {
            if (!filteredSalons.contains(e)) {
              filteredSalons.add(e);
            }
          }
        }
      }
    } else if (gender == 'women') {
      if (filteredSalons.isNotEmpty) {
        List<SalonModel> salonsToBeRemoved = [];

        for (SalonModel salon in filteredSalons) {
          if (salon.isForFemale != '1' ||
              salon.isForFemale == '1' && salon.isForMale == '1') {
            salonsToBeRemoved.add(salon);
          }
        }
        for (SalonModel salon in salonsToBeRemoved) {
          filteredSalons.remove(salon);
        }
      } else {
        var isForFemale = salons.where((element) => element.isForFemale == '1');
        if (isForFemale.isNotEmpty) {
          for (SalonModel e in isForFemale) {
            if (!filteredSalons.contains(e)) {
              filteredSalons.add(e);
            }
          }
        }
      }
    } else if (gender == 'both') {
      if (filteredSalons.isNotEmpty) {
        List<SalonModel> salonsToBeRemoved = [];

        for (SalonModel salon in filteredSalons) {
          if (salon.isForMale != '1' || salon.isForFemale != '1') {
            salonsToBeRemoved.add(salon);
          }
        }
        for (SalonModel salon in salonsToBeRemoved) {
          filteredSalons.remove(salon);
        }
      } else {
        for (SalonModel e in salons) {
          if (e.isForMale == '1' && e.isForFemale == '1') {
            if (!filteredSalons.contains(e)) {
              filteredSalons.add(e);
            }
          }
        }
      }
    }

    return filteredSalons;
  }

  /*Future<void> _getSalonsByCityHandler(
      GetSalonsByCityEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(milliseconds: 20));

    List<SalonModel> salons = state.salons ?? [];
    List<SalonModel> filteredSalons = [];

    for (SalonModel salon in salons) {
      if (int.parse(salon.city) == event.id) {
        if (!filteredSalons.contains(salon)) {
          filteredSalons.add(salon);
        }
      }
    }

    DataMap options = state.filterOptions ?? {};
    bool openNow = false, applyFilter = false, nearBy = false;
    DateTime dateTime = DateTime.now();
    Position currentPosition = await Location().determinePosition();
    if (options.isNotEmpty) {
      options.forEach((key, value) {
        if (key == 'gender') {
          if (value == 'men') {
            filteredSalons =
                filterByGender(filteredSalons, filteredSalons, 'men', '');
          } else if (value == 'women') {
            filteredSalons =
                filterByGender(filteredSalons, filteredSalons, 'women', '');
          } else if (value == 'both') {
            filteredSalons =
                filterByGender(filteredSalons, filteredSalons, 'both', '');
          } else {
            log('empty');
          }
        } else if (key == 'open_now') {
          openNow = value;
          List<SalonModel> salonsToBeRemoved = [];
          if (openNow) {
            if (filteredSalons.isNotEmpty) {
              for (SalonModel salon in filteredSalons) {
                String closeDay = salon.closeDay.toLowerCase();
                String openDay = salon.openDay.toLowerCase();
                String actualDay =
                    DateFormat('EEEE').format(dateTime).toLowerCase();

                int closeDayIndex = daysOfWeek.indexOf(closeDay);
                int actualDayIndex = daysOfWeek.indexOf(actualDay);
                int openDayIndex = daysOfWeek.indexOf(openDay);

                DateTime closeTime = convertStringToHourMnSec(salon.closeTime);
                DateTime openTime = convertStringToHourMnSec(salon.openTime);

                if (closeDayIndex > actualDayIndex &&
                        actualDayIndex > openDayIndex ||
                    closeDayIndex == actualDayIndex ||
                    actualDayIndex == openDayIndex) {
                  if (dateTime.hour < closeTime.hour &&
                      dateTime.hour > openTime.hour) {
                    if (!filteredSalons.contains(salon)) {
                      filteredSalons.add(salon);
                      applyFilter = true;
                    }
                  } else {
                    if (!salonsToBeRemoved.contains(salon)) {
                      salonsToBeRemoved.add(salon);
                    }
                  }
                } else {
                  if (!salonsToBeRemoved.contains(salon)) {
                    salonsToBeRemoved.add(salon);
                  }
                }
              }

              for (SalonModel element in salonsToBeRemoved) {
                filteredSalons.remove(element);
              }
            } else {
              for (SalonModel salon in salons) {
                String closeDay = salon.closeDay.toLowerCase();
                String openDay = salon.openDay.toLowerCase();
                String actualDay =
                    DateFormat('EEEE').format(dateTime).toLowerCase();

                int closeDayIndex = daysOfWeek.indexOf(closeDay);
                int actualDayIndex = daysOfWeek.indexOf(actualDay);
                int openDayIndex = daysOfWeek.indexOf(openDay);

                DateTime closeTime = convertStringToHourMnSec(salon.closeTime);
                DateTime openTime = convertStringToHourMnSec(salon.openTime);

                if (closeDayIndex > actualDayIndex &&
                        actualDayIndex > openDayIndex ||
                    closeDayIndex == actualDayIndex ||
                    actualDayIndex == openDayIndex) {
                  if (dateTime.hour < closeTime.hour &&
                      dateTime.hour > openTime.hour) {
                    if (!filteredSalons.contains(salon)) {
                      filteredSalons.add(salon);
                      applyFilter = true;
                    }
                  }
                }
              }
            }
          }
        } else if (key == 'near_by') {
          nearBy = value;
          List<SalonModel> salonsToBeRemoved = [];

          if (nearBy) {
            if (filteredSalons.isNotEmpty) {
              for (SalonModel salon in filteredSalons) {
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
                    applyFilter = true;
                  }
                } else {
                  if (!salonsToBeRemoved.contains(salon)) {
                    salonsToBeRemoved.add(salon);
                  }
                }
              }

              for (SalonModel element in salonsToBeRemoved) {
                filteredSalons.remove(element);
              }
            } else {
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
                    applyFilter = true;
                  }
                }
              }
            }
          }
        }
      });
    }

    if (state.categoryId != -1) {
      List<SalonModel> salonsToBeRemoved = [];
      for (SalonModel salon in filteredSalons) {
        if (int.parse(salon.categoryId) != state.categoryId) {
          salonsToBeRemoved.add(salon);
        }
      }
      for (SalonModel element in salonsToBeRemoved) {
        filteredSalons.remove(element);
      }
    }

    emit(state.copyWith(
        cityId: event.id,
        applyFilter: true,
        status: FormzSubmissionStatus.success,
        filteredSalons: filteredSalons,
        successMessage: ''));
  } */

  /* Future<void> _getSalonsByCategoryHandler(
      GetSalonsByCategoryEvent event, Emitter<SalonState> emit) async {
    emit(state.copyWith(
        status: FormzSubmissionStatus.inProgress, filteredSalons: null));
    await Future.delayed(const Duration(milliseconds: 20));

    bool applyFilter = false;
    int categoryId = state.categoryId;
    List<SalonModel> filteredSalons = state.filteredSalons ?? [];

    if (categoryId == int.parse(event.id)) {
      applyFilter = false;
    } else {
      applyFilter = true;
    }

    final result = await _getSalonsByCategoryUseCase(event.id);

    result.fold((l) => null, (r) {
      List<SalonModel> salons = r.data ?? [];

      List<SalonModel> output =
          salons.where((element) => filteredSalons.contains(element)).toList();

      for (SalonModel salon in output) {
        if (int.parse(salon.city) == state.cityId) {
          if (!filteredSalons.contains(salon)) {
            filteredSalons.add(salon);
          } else {
            log('remove');
          }
        }
      }
    });

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getSalonsByCategory)),
        (r) => emit(state.copyWith(
            categoryId: int.parse(event.id),
            applyFilter: applyFilter,
            status: FormzSubmissionStatus.success,
            filteredSalons: filteredSalons,
            action: RequestType.getSalonsByCategory,
            successMessage: '')));
  }*/

  Future<void> _getSalonsHandler(GetSalonsEvent event,
      Emitter<SalonState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(milliseconds: 50));

    final result = await _getSalonsUseCase(event.queryParameters);

    int categoryId = state.categoryId;
    bool applyFilter = state.applyFilter;

    if (event.queryParameters['category_id'] != null) {
      if (categoryId == int.parse(event.queryParameters['category_id'])) {
        applyFilter = false;
      } else {
        applyFilter = true;
      }
      categoryId = int.parse(event.queryParameters['category_id']);
    }

    result.fold(
            (l) =>
            emit(state.copyWith(
                status: FormzSubmissionStatus.failure,
                errorMessage: l.message,
                action: RequestType.getSalons)),
            (r) =>
            emit(state.copyWith(
                categoryId: categoryId,
                applyFilter: applyFilter,
                status: FormzSubmissionStatus.success,
                salons: r.salons,
                action: RequestType.getSalons,
                successMessage: '')));
  }
}
