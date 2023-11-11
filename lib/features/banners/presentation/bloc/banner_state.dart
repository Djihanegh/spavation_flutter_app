part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

class BannerInitialState extends BannerState {}

class BannerInProgressState extends BannerState {}

class BannerLoadDataSuccessState extends BannerState {
  final List<BannerModel> banners;

  @override
  List<Object> get props => [banners];

  const BannerLoadDataSuccessState({
    required this.banners,
  });
}

class BannerLoadDataFailureState extends BannerState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const BannerLoadDataFailureState({
    required this.errorMessage,
  });
}
