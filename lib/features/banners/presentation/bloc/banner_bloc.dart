import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:spavation/core/enum/enum.dart';
import 'package:spavation/features/banners/data/models/banner_model.dart';
import 'package:spavation/features/banners/domain/usecases/get_banners.dart';

part 'banner_event.dart';

part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required GetBannersUseCase getBannersUseCase})
      : _getBannersUseCase = getBannersUseCase,
        super(const BannerState()) {
    on<BannerEvent>(_onGetBannersHandler);
  }

  final GetBannersUseCase _getBannersUseCase;

  Future<void> _onGetBannersHandler(
      BannerEvent event, Emitter<BannerState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    await Future.delayed(const Duration(seconds: 2));

    final result = await _getBannersUseCase();

    result.fold(
        (l) => emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: l.message,
            action: RequestType.getBanners)),
        (r) => emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            banners: r.banners,
            successMessage: '',
            action: RequestType.getBanners)));
  }
}
