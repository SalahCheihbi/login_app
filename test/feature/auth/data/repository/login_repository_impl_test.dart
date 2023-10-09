import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/auth/data/models/token_model.dart';
import 'package:login_app/features/auth/data/repository/login_repository_impl.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginRemoteDataSource mockLoginRemoteDataSource;
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLoginLocalDataSource mockLoginLocalDataSource;

  setUp(() {
    mockLoginRemoteDataSource = MockLoginRemoteDataSource();
    mockLoginLocalDataSource = MockLoginLocalDataSource();
    loginRepositoryImpl = LoginRepositoryImpl(
        netWorkInfo: MockNetWorkInfo(),
        localDataSource: mockLoginLocalDataSource,
        remoteDataSource: mockLoginRemoteDataSource);
  });

  List<TokenModel> tTokenEntity = [
    const TokenModel(
      token: 'test',
    )
  ];

  group('get current login ', () {
    test('should return current login when a call to data source is successful',
        () async {
      // arrange
      when(mockLoginLocalDataSource.cachedLogin(tTokenEntity))
          .thenAnswer((_) async {
        return unit;
      });

      // Stub the isConnected method
      when(loginRepositoryImpl.netWorkInfo.isConnected)
          .thenAnswer((_) => Future.value(true));

      // arrange
      when(mockLoginRemoteDataSource.getLogin('test@gmail.com', 'test1234'))
          .thenAnswer((_) => Future.value(tTokenEntity));

      // act
      final result =
          await loginRepositoryImpl.login('test@gmail.com', 'test1234');

      // assert
      expect(result, equals(Right<Failure, List<TokenEntity>>(tTokenEntity)));
    });
  });
}
