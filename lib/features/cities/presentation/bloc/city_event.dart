part of 'cities_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
}

class GetCitiesEvent extends CityEvent {
  const GetCitiesEvent();

  @override
  List<Object?> get props => [];
}
