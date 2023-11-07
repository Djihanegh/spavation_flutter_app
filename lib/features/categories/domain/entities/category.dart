import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.id,
    required this.image,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.nameAr
  });

  final int id;
  final String image;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String status;
  final String nameAr;

  @override
  List<Object?> get props => [id, image, name, updatedAt, createdAt, status, nameAr];
}
