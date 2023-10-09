import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/auth/domain/entities/login_entity.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';
import 'package:login_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginBloc = LoginBloc(loginUseCase: mockLoginUseCase);
  });
  const testToken = TokenEntity(token: 'test');

  const testLogin = LoginEntity(email: 'test@gmail.com', password: 'test123');

  test('intial state should be empty', () {
    expect(loginBloc.state, LoginInitial());
  });

  blocTest<LoginBloc, LoginState>(
      'should emit [LoginLoading, LoginLoaded] when data is gotten',
      build: () {
        when(mockLoginUseCase.call(testLogin.email, testLogin.password))
            .thenAnswer((realInvocation) async => const Right([testToken]));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
            LoginCheckEvent(
                email: testLogin.email, password: testLogin.password),
          ),
      expect: () => [
            LoginLoadingState(),
            const LoginSuccessState(loginList: [testToken]),
          ]);
  blocTest<LoginBloc, LoginState>(
      'should emit [LoginLoading, LoginFailure] when data is unsuccessful',
      build: () {
        when(mockLoginUseCase.call(testLogin.email, testLogin.password))
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        return loginBloc;
      },
      act: (bloc) => bloc.add(
            LoginCheckEvent(
                email: testLogin.email, password: testLogin.password),
          ),
      expect: () => [
            LoginLoadingState(),
            const LoginErrorState(
                message: 'Authentication failed. Invalid user or password.'),
          ]);
}
