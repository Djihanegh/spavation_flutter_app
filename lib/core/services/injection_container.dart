import 'package:get_it/get_it.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source_implementation.dart';
import 'package:spavation/features/authentication/data/repositories/authentification_repository_implementation.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:spavation/features/authentication/domain/usecases/check_otp.dart';
import 'package:spavation/features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/resend_otp.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:spavation/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:spavation/features/categories/data/datasources/category_remote_data_source_implementation.dart';
import 'package:spavation/features/categories/data/repositories/category_repository_implementation.dart';
import 'package:spavation/features/categories/domain/repositories/category_repository.dart';
import 'package:spavation/features/categories/domain/usecases/get_categories.dart';
import 'package:spavation/features/categories/presentation/bloc/category_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // App Logic
  sl
    ..registerFactory(() => AuthenticationBloc(
        registerUser: sl(),
        loginUser: sl(),
        checkOtpUseCase: sl(),
        resendOtpUseCase: sl()))
    ..registerFactory(() => CategoryBloc(getCategoriesUseCase: sl()))

    // Use cases
    ..registerLazySingleton(() => RegisterUser(sl()))
    ..registerLazySingleton(() => LoginUser(sl()))
    ..registerLazySingleton(() => CheckOtpUseCase(sl()))
    ..registerLazySingleton(() => ResendOtpUseCase(sl()))
    ..registerLazySingleton(() => GetCategoriesUseCase(sl()))
    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    ..registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImplementation(sl()))
    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
    ..registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSrcImpl(sl()))
    // External Dependencies
    ..registerLazySingleton(() => http.Client());
}
