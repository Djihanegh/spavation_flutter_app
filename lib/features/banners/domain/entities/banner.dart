import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  const Banner(
      {required this.id,
      required this.image,
      required this.name,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.salonId});

  final int id;
  final String image;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String salonId;

  @override
  List<Object?> get props =>
      [id, image, name, updatedAt, createdAt, status, salonId];
}
