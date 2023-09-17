part of 'banner_bloc.dart';

abstract class BannerEvent extends Equatable {
  const BannerEvent();
}

class GetBannersEvent extends BannerEvent {
  const GetBannersEvent();

  @override
  List<Object?> get props => [];
}
