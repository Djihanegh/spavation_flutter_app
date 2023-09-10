import 'dart:convert';
import 'dart:developer';

import 'package:spavation/core/errors/exceptions.dart';
import 'package:spavation/core/utils/endpoint.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/domain/entities/create_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/login_user_response.dart';
import 'package:spavation/features/authentication/domain/entities/user.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  AuthRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<CreateUserResponse> createUser({required UserModel user}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.register),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: user.toJson());

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      log(response.body.toString());

      return CreateUserResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<LoginUserResponse> loginUser({required UserModel user}) async {
    try {
      final response = await _client.post(
          Uri.parse(Endpoints.baseUrl + Endpoints.login),
          body: UserModel.loginUserModel(user));

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }

      return LoginUserResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
