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

/*class GetSalonsByCategoryEvent extends SalonEvent {
  const GetSalonsByCategoryEvent(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

class GetSalonsByCityEvent extends SalonEvent {
  const GetSalonsByCityEvent(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
*/
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
