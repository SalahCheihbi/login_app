import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
}
