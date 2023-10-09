import 'package:dartz/dartz.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';
import 'package:login_app/features/general/domain/repository/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository profileRepository;
  GetProfileUseCase(this.profileRepository);
  Future<Either<Failure, ProfileEntity>> call() {
    return profileRepository.getProfile();
  }
}
