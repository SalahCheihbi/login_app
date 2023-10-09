import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/core/network/network_info.dart';
import 'package:login_app/features/auth/data/datasources/login_local_data_source.dart';
import 'package:login_app/features/auth/data/datasources/login_remote_data_source.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';
import 'package:login_app/features/auth/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetWorkInfo netWorkInfo;
  final LoginLocalDataSource localDataSource;
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(
      {required this.netWorkInfo,
      required this.localDataSource,
      required this.remoteDataSource});
  @override
  Future<Either<Failure, List<TokenEntity>>> login(
      String email, String password) async {
    if (await netWorkInfo.isConnected) {
      try {
        final remoteLogin = await remoteDataSource.getLogin(email, password);
        localDataSource.cachedLogin(remoteLogin);
        return Right(remoteLogin);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localLogin = await localDataSource.getCachedLogin();
        return Right(localLogin);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
