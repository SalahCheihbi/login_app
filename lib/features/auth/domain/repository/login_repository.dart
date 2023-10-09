import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, List<TokenEntity>>> login(
      String email, String password);
}
