import 'dart:convert';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:spavation/core/services/location_service.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source.dart';
import 'package:spavation/features/salons/data/models/salon_model.dart';
import 'package:spavation/features/salons/domain/entities/get_salons_response.dart';

import '../../../../core/errors/api_message_handler.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';
import '../../../../core/utils/typedef.dart';

class SalonRemoteDataSrcImpl implements SalonRemoteDataSource {
  SalonRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetSalonsResponse> getSalons(DataMap data) async {
    http.Response? response;
    DataMap queryParams = {};
    try {
      if (data.isNotEmpty) {
        if (data['open_now'] != null) {
          if (data['open_now'].toString() == "true") {
            queryParams['is_open'] = "1";
          }
        }

        if (data['city'] != null) {
          queryParams['city'] = data['city'];
        }
        if (data['category_id'] != null) {
          queryParams['category_id'] = data['category_id'];
        }

        if (data['gender'] != null) {
          if (data['gender'] == 'men') {
            queryParams['is_for_male'] = "1";
            queryParams['is_for_female'] = "2";
          } else if (data['gender'] == 'women') {
            queryParams['is_for_male'] = "2";
          } else if (data['gender'] == 'both') {
            queryParams['is_for_female'] = "1";
            queryParams['is_for_male'] = "1";
          }
        }
      }
      final uri = Uri.parse(Endpoints.baseUrl + Endpoints.salons)
          .replace(queryParameters: queryParams);
      response = await _client
          .get(
            uri,
            headers: headers,
          )
          .timeout(Endpoints.connectionTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: '', statusCode: response.statusCode);
      }

      List<dynamic> list = jsonDecode(response.body);

      List<SalonModel> salons = [];
      try {
        salons = list.map((e) => SalonModel.fromJson(e)).toList();
      } catch (e) {
        log(e.toString());
      }

      return GetSalonsResponse(salons);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }

  @override
  Future<GetSalonsResponse> searchSalons(String name) async {
    http.Response? response;
    try {
      response = await _client
          .get(
            Uri.parse(Endpoints.baseUrl + Endpoints.searchSalons + name),
            headers: headers,
          )
          .timeout(Endpoints.connectionTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: '', statusCode: response.statusCode);
      }

      List<dynamic> list = jsonDecode(response.body);

      List<SalonModel> salons = [];
      try {
        salons = list.map((e) => SalonModel.fromJson(e)).toList();
      } catch (e) {
        log(e.toString());
      }

      return GetSalonsResponse(salons);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
          message: catchExceptions(response, e),
          statusCode: response != null ? response.statusCode : 505);
    }
  }
}
