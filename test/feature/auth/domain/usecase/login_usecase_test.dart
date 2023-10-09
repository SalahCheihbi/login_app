import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';
import 'package:login_app/features/auth/domain/usecase/login_usecase.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginRepository mockLoginRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    useCase = LoginUseCase(mockLoginRepository);
  });
  List<TokenEntity> loginEntity = [
    const TokenEntity(
      token: 'test',
    ),
  ];
  test('should get login detail from the repository', () async {
    // arrange
    when(mockLoginRepository.login('test@gmail.com', 'test1234'))
        .thenAnswer((_) async => Right(loginEntity));
    // act
    final result = await useCase.call('test@gmail.com', 'test1234');

    // assert
    expect(result, Right(loginEntity));
  });
}
