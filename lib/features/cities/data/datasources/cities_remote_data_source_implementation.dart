import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spavation/features/cities/data/models/cities_model.dart';
import 'package:spavation/features/cities/domain/entities/get_cities_response.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/endpoint.dart';
import 'cities_remote_data_source.dart';

class CitiesRemoteDataSrcImpl implements CitiesRemoteDataSource {
  CitiesRemoteDataSrcImpl(this._client);

  final http.Client _client;

  @override
  Future<GetCitiesResponse> getCities() async {
    try {
      final response = await _client.get(
        Uri.parse(Endpoints.baseUrl + Endpoints.cities),
        headers: headers,
      ).timeout(Endpoints.connectionTimeout);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(message: '', statusCode: response.statusCode);
      }

      List<dynamic> list = jsonDecode(response.body);

      List<CitiesModel> cities =
          list.map((e) => CitiesModel.fromJson(e)).toList();

      return GetCitiesResponse(cities);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
