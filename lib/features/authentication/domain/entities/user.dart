import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class User extends Equatable {
  User({this.name, this.email, this.password, this.phone, this.address,
      this.latitude, this.longitude, this.birthday, this.gender});

  User.login({
    this.name,
    this.password,
  });

  String? name;
  String? email;
  String? phone;
  String? password;
  String? address;
  String? latitude;
  String? longitude;
  String? birthday;
  String? gender;

  @override
  List<Object?> get props => ["Email : $email , Password : $password"];
}
