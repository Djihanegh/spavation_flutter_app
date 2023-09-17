import 'package:spavation/core/utils/typedef.dart';

import '../entities/get_banners_response.dart';

abstract class BannersRepository {
  const BannersRepository();

  ResultFuture<GetBannersResponse> getBanners();
}
