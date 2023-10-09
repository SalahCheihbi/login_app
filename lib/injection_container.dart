import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:login_app/core/network/network_info.dart';
import 'package:login_app/features/auth/data/datasources/login_local_data_source.dart';
import 'package:login_app/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:login_app/features/auth/data/repository/login_repository_impl.dart';
import 'package:login_app/features/auth/domain/repository/login_repository.dart';
import 'package:login_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:login_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:login_app/features/general/data/datasources/profile_local_data_source.dart';
import 'package:login_app/features/general/data/datasources/profile_remote_data_source.dart';
import 'package:login_app/features/general/data/repository/profile_repository_impl.dart';
import 'package:login_app/features/general/domain/repository/profile_repository.dart';
import 'package:login_app/features/general/domain/usercase/get_profile.dart';
import 'package:login_app/features/general/presentation/bloc/profile/profile_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerFactory(() => LoginBloc(
        loginUseCase: sl(),
      ));
  sl.registerFactory(
    () => ProfileBloc(profileUseCase: sl()),
  );
  // Use Case
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));

  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
        netWorkInfo: sl(),
        localDataSource: sl(),
        remoteDataSource: sl(),
      ));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
        profileRemoteDataSource: sl(),
        netWorkInfo: sl(),
        localDataSource: sl(),
      ));
  // Data Source
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
            client: sl(),
          ));
  // Local Data source
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<ProfileLocalDataSource>(
      () => ProfileLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetWorkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //Client
  sl.registerLazySingleton(() => http.Client());
  // Check Internet
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
