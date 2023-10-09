import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';
import 'package:login_app/features/general/domain/usercase/get_profile.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockProfileRepository mockProfileRepository;
  late GetProfileUseCase getProfileUseCase;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getProfileUseCase = GetProfileUseCase(mockProfileRepository);
  });

  ProfileEntity tProfileEntity = const ProfileEntity(
      name: 'name',
      profile: 'profile',
      zone: 'zone',
      controlSector: 'controlSector');

  test('should get profile from the repository', () async {
    // arrange
    when(mockProfileRepository.getProfile())
        .thenAnswer((_) async => Right(tProfileEntity));
    // act
    final result = await getProfileUseCase.call();
    // assert
    expect(result, Right(tProfileEntity));
  });
}
