part of 'banner_bloc.dart';

final class BannerState extends Equatable {
  const BannerState(
      {this.status = FormzSubmissionStatus.initial,
      this.errorMessage = '',
      this.successMessage = '',
      this.banners,
      this.action = RequestType.unknown});

  final FormzSubmissionStatus status;

  final String errorMessage;
  final String successMessage;
  final List<BannerModel>? banners;
  final RequestType? action;

  BannerState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    String? successMessage,
    List<BannerModel>? banners,
    RequestType? action,
  }) {
    return BannerState(
        action: action ?? this.action,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        successMessage: successMessage ?? this.successMessage,
        banners: banners ?? this.banners);
  }

  @override
  List<Object?> get props =>
      [action, status, errorMessage, successMessage, banners];
}
