import 'package:get_it/get_it.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source_implementation.dart';
import 'package:spavation/features/authentication/data/repositories/authentification_repository_implementation.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:spavation/features/authentication/domain/usecases/check_otp.dart';
import 'package:spavation/features/authentication/domain/usecases/get_user.dart';
import 'package:spavation/features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/resend_otp.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spavation/features/banners/data/datasources/banners_remote_data_source.dart';
import 'package:spavation/features/banners/data/datasources/banners_remote_data_source_implementation.dart';
import 'package:spavation/features/banners/data/repositories/banners_repository_implementation.dart';
import 'package:spavation/features/banners/domain/repositories/banners_repository.dart';
import 'package:spavation/features/banners/domain/usecases/get_banners.dart';
import 'package:spavation/features/banners/presentation/bloc/banner_bloc.dart';
import 'package:spavation/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:spavation/features/categories/data/datasources/category_remote_data_source_implementation.dart';
import 'package:spavation/features/categories/data/repositories/category_repository_implementation.dart';
import 'package:spavation/features/categories/domain/repositories/category_repository.dart';
import 'package:spavation/features/categories/domain/usecases/get_categories.dart';
import 'package:spavation/features/categories/presentation/bloc/category_bloc.dart';
import 'package:spavation/features/products/data/datasources/products_remote_data_source.dart';
import 'package:spavation/features/products/data/datasources/products_remote_data_source_implementation.dart';
import 'package:spavation/features/products/data/repositories/products_repository_implementation.dart';
import 'package:spavation/features/products/domain/repositories/products_repository.dart';
import 'package:spavation/features/products/domain/usecases/get_products.dart';
import 'package:spavation/features/products/presentation/bloc/product_bloc.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source_implementation.dart';
import 'package:spavation/features/salons/data/repositories/salon_repository_implementation.dart';
import 'package:spavation/features/salons/domain/repositories/salon_repository.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';
import 'package:spavation/features/salons/presentation/bloc/salon_bloc.dart';
import 'package:spavation/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:spavation/features/settings/data/datasources/settings_remote_data_source_implementation.dart';
import 'package:spavation/features/settings/data/repositories/settings_repository_implementation.dart';
import 'package:spavation/features/settings/domain/repositories/settings_repository.dart';
import 'package:spavation/features/settings/domain/usecases/delete_user.dart';
import 'package:spavation/features/settings/domain/usecases/get_user_details.dart';
import 'package:spavation/features/settings/domain/usecases/update_user.dart';
import 'package:spavation/features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // App Logic
  sl
    ..registerFactory(() => AuthenticationBloc(
        registerUser: sl(),
        loginUser: sl(),
        checkOtpUseCase: sl(),
        resendOtpUseCase: sl(),
        getUserUseCase: sl()))
    ..registerFactory(() => CategoryBloc(getCategoriesUseCase: sl()))
    ..registerFactory(() => BannerBloc(
          getBannersUseCase: sl(),
        ))
    ..registerFactory(() => SalonBloc(getSalonsUseCase: sl()))
    ..registerFactory(() => ProductBloc(getProductsUseCase: sl()))
    ..registerFactory(() => SettingsBloc(
        getUserDetailsUseCase: sl(),
        deleteUserUseCase: sl(),
        updateUserUseCasez: sl()))

    // Use cases
    ..registerLazySingleton(() => RegisterUser(sl()))
    ..registerLazySingleton(() => LoginUser(sl()))
    ..registerLazySingleton(() => CheckOtpUseCase(sl()))
    ..registerLazySingleton(() => ResendOtpUseCase(sl()))
    ..registerLazySingleton(() => GetCategoriesUseCase(sl()))
    ..registerLazySingleton(() => GetBannersUseCase(sl()))
    ..registerLazySingleton(() => GetSalonsUseCase(sl()))
    ..registerLazySingleton(() => GetProductsUseCase(sl()))
    ..registerLazySingleton(() => GetUserUseCase(sl()))
    ..registerLazySingleton(() => GetUserDetailsUseCase(sl()))
    ..registerLazySingleton(() => DeleteUserUseCase(sl()))
    ..registerLazySingleton(() => UpdateUserUseCase(sl()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImplementation(sl()))
    ..registerLazySingleton<BannersRepository>(
        () => BannersRepositoryImplementation(sl()))
    ..registerLazySingleton<SalonRepository>(
        () => SalonRepositoryImplementation(sl()))
    ..registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImplementation(sl()))
    ..registerLazySingleton<SettingsRepository>(
        () => SettingsRepositoryImplementation(sl()))

    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<BannersRemoteDataSource>(
        () => BannersRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<SalonRemoteDataSource>(
        () => SalonRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<ProductsRemoteDataSource>(
        () => ProductsRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<SettingsRemoteDataSource>(
        () => SettingsRemoteDataSrcImpl(sl()))
    // External Dependencies
    ..registerLazySingleton(() => http.Client());
}
