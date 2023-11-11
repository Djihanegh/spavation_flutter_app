part of 'cities_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitialState extends CityState {}

class CityInProgressState extends CityState {}

class CityLoadDataSuccessState extends CityState {
  final List<CitiesModel> cities;

  @override
  List<Object> get props => [cities];

  const CityLoadDataSuccessState({
    required this.cities,
  });
}

class CityLoadDataFailureState extends CityState {
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];

  const CityLoadDataFailureState({
    required this.errorMessage,
  });
}
