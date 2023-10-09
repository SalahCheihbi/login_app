import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/exceptions.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/core/network/network_info.dart';
import 'package:login_app/features/general/data/datasources/profile_local_data_source.dart';
import 'package:login_app/features/general/data/datasources/profile_remote_data_source.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';
import 'package:login_app/features/general/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final NetWorkInfo netWorkInfo;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl(
      {required this.netWorkInfo,
      required this.profileRemoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    if (await netWorkInfo.isConnected) {
      try {
        final remoteProfile = await profileRemoteDataSource.getProfile();
        return Right(remoteProfile);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProfile = await localDataSource.getCachedProfile();
        return Right(localProfile);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
