import 'package:spavation/core/usecase/usecase.dart';
import 'package:spavation/core/utils/typedef.dart';
import 'package:spavation/features/banners/domain/repositories/banners_repository.dart';
import 'package:spavation/features/categories/domain/repositories/category_repository.dart';
import '../entities/get_banners_response.dart';

class GetBannersUseCase extends UseCaseWithoutParams<GetBannersResponse> {
  const GetBannersUseCase(this._repository);

  final BannersRepository _repository;

  @override
  ResultFuture<GetBannersResponse> call() async => _repository.getBanners();
}
