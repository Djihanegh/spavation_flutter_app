import 'package:get_it/get_it.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:spavation/features/authentication/data/datasources/authentication_remote_data_source_implementation.dart';
import 'package:spavation/features/authentication/data/repositories/authentification_repository_implementation.dart';
import 'package:spavation/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:spavation/features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:spavation/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:spavation/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // App Logic
  sl
    ..registerFactory(
        () => AuthenticationBloc(registerUser: sl(), loginUser: sl()))

    // Use cases
    ..registerLazySingleton(() => RegisterUser(sl()))
    ..registerLazySingleton(() => LoginUser(sl()))
    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))
    // External Dependencies
    ..registerLazySingleton(() => http.Client());
}
