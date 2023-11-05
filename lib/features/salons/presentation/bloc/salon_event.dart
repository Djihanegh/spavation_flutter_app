part of 'salon_bloc.dart';

abstract class SalonEvent extends Equatable {
  const SalonEvent();
}

class GetSalonsEvent extends SalonEvent {
  const GetSalonsEvent(this.queryParameters);

  final DataMap queryParameters;

  @override
  List<Object?> get props => [queryParameters];
}

class SearchSalonsEvent extends SalonEvent {
  const SearchSalonsEvent(this.text);

  final String text;

  @override
  List<Object?> get props => [text];
}

class SelectFilterOptions extends SalonEvent {
  const SelectFilterOptions(this.options);

  final DataMap options;

  @override
  List<Object?> get props => [options];
}
