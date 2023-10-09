import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/general/data/models/profile_model.dart';
import 'package:login_app/features/general/data/repository/profile_repository_impl.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late ProfileRepositoryImpl profileRepositoryImpl;
  late MockProfileLocalDataSource mockProfileLocalDataSource;
  late MockProfileRemoteDataSource mockProfileRemoteDataSource;

  setUp(() {
    mockProfileLocalDataSource = MockProfileLocalDataSource();
    mockProfileRemoteDataSource = MockProfileRemoteDataSource();
    profileRepositoryImpl = ProfileRepositoryImpl(
        netWorkInfo: MockNetWorkInfo(),
        profileRemoteDataSource: mockProfileRemoteDataSource,
        localDataSource: mockProfileLocalDataSource);
  });

  ProfileModel tProfileEntity = const ProfileModel(
      name: 'name',
      profile: 'profile',
      zone: 'zone',
      controlSector: 'controlSector');

  group('get current Profile ', () {
    test('should return current login when a call to data source is successful',
        () async {
      // arrange
      when(mockProfileLocalDataSource.cachedProfile([tProfileEntity]))
          .thenAnswer((_) async {
        return unit;
      });

      // Stub the isConnected method
      when(profileRepositoryImpl.netWorkInfo.isConnected)
          .thenAnswer((_) => Future.value(true));

      // arrange
      when(mockProfileRemoteDataSource.getProfile())
          .thenAnswer((_) => Future.value(tProfileEntity));

      // act
      final result = await profileRepositoryImpl.getProfile();

      // assert
      expect(result, equals(Right<Failure, ProfileEntity>(tProfileEntity)));
    });
  });
}
