import 'package:get_it/get_it.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source_implementation.dart';
import 'package:spavation/features/authentication/data/repositories/authentification_repository_implementation.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:spavation/features/authentication/domain/usecases/check_otp.dart';
import 'package:spavation/features/authentication/domain/usecases/check_otp_forget_password.dart';
import 'package:spavation/features/authentication/domain/usecases/get_user.dart';
import 'package:spavation/features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/resend_otp.dart';
import 'package:spavation/features/authentication/domain/usecases/send_otp_forget_password_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/update_password_usecase.dart';
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
import 'package:spavation/features/cities/data/datasources/cities_remote_data_source.dart';
import 'package:spavation/features/cities/data/datasources/cities_remote_data_source_implementation.dart';
import 'package:spavation/features/cities/data/repositories/salon_repository_implementation.dart';
import 'package:spavation/features/cities/domain/repositories/cities_repository.dart';
import 'package:spavation/features/cities/domain/usecases/get_cities.dart';
import 'package:spavation/features/products/data/datasources/products_remote_data_source.dart';
import 'package:spavation/features/products/data/datasources/products_remote_data_source_implementation.dart';
import 'package:spavation/features/products/data/repositories/products_repository_implementation.dart';
import 'package:spavation/features/products/domain/repositories/products_repository.dart';
import 'package:spavation/features/products/domain/usecases/get_products.dart';
import 'package:spavation/features/products/presentation/bloc/product_bloc.dart';
import 'package:spavation/features/reservation/data/datasources/reservation_remote_data_source.dart';
import 'package:spavation/features/reservation/domain/repositories/reservation_repository.dart';
import 'package:spavation/features/reservation/domain/usecases/add_reservation.dart';
import 'package:spavation/features/reservation/domain/usecases/check_coupon.dart';
import 'package:spavation/features/reservation/domain/usecases/get_reservations.dart';
import 'package:spavation/features/reservation/presentation/bloc/reservation_bloc.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source.dart';
import 'package:spavation/features/salons/data/datasources/salons_remote_data_source_implementation.dart';
import 'package:spavation/features/salons/data/repositories/salon_repository_implementation.dart';
import 'package:spavation/features/salons/domain/repositories/salon_repository.dart';
import 'package:spavation/features/salons/domain/usecases/get_salons.dart';
import 'package:spavation/features/salons/domain/usecases/search_salons_by_category.dart';
import 'package:spavation/features/salons/presentation/bloc/salon_bloc.dart';
import 'package:spavation/features/settings/data/datasources/settings_remote_data_source.dart';
import 'package:spavation/features/settings/data/datasources/settings_remote_data_source_implementation.dart';
import 'package:spavation/features/settings/data/repositories/settings_repository_implementation.dart';
import 'package:spavation/features/settings/domain/repositories/settings_repository.dart';
import 'package:spavation/features/settings/domain/usecases/delete_user.dart';
import 'package:spavation/features/settings/domain/usecases/get_user_details.dart';
import 'package:spavation/features/settings/domain/usecases/update_user.dart';
import 'package:spavation/features/settings/presentation/bloc/settings_bloc.dart';

import '../../features/cities/presentation/bloc/cities_bloc.dart';
import '../../features/products/domain/usecases/get_product_times_usecase.dart';
import '../../features/reservation/data/datasources/reservation_remote_data_source_implementation.dart';
import '../../features/reservation/data/repositories/reservation_repository_implementation.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // App Logic
  sl
    ..registerFactory(() => AuthenticationBloc(
        registerUser: sl(),
        loginUser: sl(),
        checkOtpUseCase: sl(),
        resendOtpUseCase: sl(),
        getUserUseCase: sl(),
        updatePasswordUseCase: sl(),
        checkOtpForgetPasswordUseCase: sl(),
        sendOtpForgetPasswordUseCase: sl()))
    ..registerFactory(() => CategoryBloc(getCategoriesUseCase: sl()))
    ..registerFactory(() => BannerBloc(
          getBannersUseCase: sl(),
        ))
    ..registerFactory(() => CityBloc(
          getCitiesUseCase: sl(),
        ))
    ..registerFactory(
        () => SalonBloc(getSalonsUseCase: sl(), searchSalonsUseCase: sl()))
    ..registerFactory(() =>
        ProductBloc(getProductsUseCase: sl(), getProductTimesUseCase: sl()))
    ..registerFactory(() => SettingsBloc(
        getUserDetailsUseCase: sl(),
        deleteUserUseCase: sl(),
        updateUserUseCasez: sl()))
    ..registerFactory(() => ReservationBloc(
        getReservationsUseCase: sl(),
        checkCouponUseCase: sl(),
        addReservationUseCase: sl()))

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
    ..registerLazySingleton(() => GetReservationsUseCase(sl()))
    ..registerLazySingleton(() => CheckCouponUseCase(sl()))
    ..registerLazySingleton(() => AddReservationUseCase(sl()))
    ..registerLazySingleton(() => UpdatePasswordUseCase(sl()))
    ..registerLazySingleton(() => CheckOtpForgetPasswordUseCase(sl()))
    ..registerLazySingleton(() => SendOtpForgetPasswordUseCase(sl()))
    ..registerLazySingleton(() => SearchSalonsUseCase(sl()))
    ..registerLazySingleton(() => GetCitiesUseCase(sl()))
    ..registerLazySingleton(() => GetProductTimesUseCase(sl()))

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
    ..registerLazySingleton<ReservationsRepository>(
        () => ReservationRepositoryImplementation(sl()))
    ..registerLazySingleton<CitiesRepository>(
        () => CitiesRepositoryImplementation(sl()))

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
    ..registerLazySingleton<ReservationsRemoteDataSource>(
        () => ReservationsRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<CitiesRemoteDataSource>(
        () => CitiesRemoteDataSrcImpl(sl()))
    // External Dependencies
    ..registerLazySingleton(() => http.Client());
}
