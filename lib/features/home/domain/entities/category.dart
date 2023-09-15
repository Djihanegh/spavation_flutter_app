import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({required this.id, required this.image, required this.name});

  final int id;
  final String image;
  final String name;

  @override
  List<Object?> get props => [id, image, name];
}
