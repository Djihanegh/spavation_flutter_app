import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:spavation/core/services/location_service.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_response.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/get_salons_by_category_response.dart';

class SalonRemoteDataSrcImpl implements SalonRemoteDataSource {
  SalonRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetSalonsResponse> getSalons() async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.salons),
        headers: headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: '', statusCode: response.statusCode);
      }

      List<dynamic> list = jsonDecode(response.body);

      List<SalonModel> salons =
          list.map((e) => SalonModel.fromJson(e)).toList();

      return GetSalonsResponse(salons);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<GetSalonsByCategoryResponse> getSalonsByCategory(String id) async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.salonsByCategory + id),
        headers: headers,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: '', statusCode: response.statusCode);
      }

      return GetSalonsByCategoryResponse.fromJson(jsonDecode(response.body));
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
