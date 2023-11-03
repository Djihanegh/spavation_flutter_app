import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String nameAr;
  final String latitude;
  final String longitude;

  @override
  List<Object> get props => [
        id,
        name,
        createdAt,
        updatedAt,
        latitude,
        longitude,
      ];
}
