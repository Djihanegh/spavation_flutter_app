import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spavation/features/banners/data/models/banner_model.dart';
import 'package:spavation/features/banners/domain/usecases/get_banners.dart';

part 'banner_event.dart';

part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required GetBannersUseCase getBannersUseCase})
      : _getBannersUseCase = getBannersUseCase,
        super(BannerInitialState()) {
    on<BannerEvent>(_onGetBannersHandler);
  }

  final GetBannersUseCase _getBannersUseCase;

  Future<void> _onGetBannersHandler(
      BannerEvent event, Emitter<BannerState> emit) async {
    emit.call(BannerInProgressState());
    await Future.delayed(const Duration(milliseconds: 20));

    final result = await _getBannersUseCase();

    result.fold(
        (l) => emit.call(BannerLoadDataFailureState(errorMessage: l.message)),
        (r) => emit.call(BannerLoadDataSuccessState(banners: r.banners ?? [])));
  }
}
