import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.birthday,
      required this.gender});

  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;
  final String latitude;
  final String longitude;
  final String birthday;
  final String gender;

  @override
  List<Object?> get props => ["Email : $email , Password : $password"];
}
