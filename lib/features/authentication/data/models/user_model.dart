// ignore_for_file: must_be_immutable

import 'dart:convert';

import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.name,
    super.email,
    super.password,
    super.phone,
    super.address,
    super.latitude,
    super.longitude,
    super.birthday,
    super.gender,
  });

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          name: map['name'] as String,
          email: map['email'] as String,
          password: map['password'] as String,
          phone: map['phone'] as String,
          address: map['address'] as String,
          latitude: map['latitude'] as String,
          longitude: map['longitude'] as String,
          birthday: map['birthday'] as String,
          gender: map['gender'] as String,
        );

  UserModel.loginUserModel(UserModel user)
      : this(
          phone: user.phone,
        );

  DataMap toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        'password': password,
        'latitude': latitude,
        'longitude': longitude,
        'birthday': birthday,
        'gender': gender
      };

  String toJson() => jsonEncode(toMap());
}
