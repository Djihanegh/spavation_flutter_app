import '../../domain/entities/get_banners_response.dart';

abstract class BannersRemoteDataSource {
  Future<GetBannersResponse> getBanners();
}
