import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';
import 'package:login_app/features/auth/domain/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase(this.loginRepository);
  Future<Either<Failure, List<TokenEntity>>> call(
      String email, String password) {
    return loginRepository.login(email, password);
  }
}
