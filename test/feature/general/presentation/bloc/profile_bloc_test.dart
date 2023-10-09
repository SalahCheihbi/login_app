import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';
import 'package:login_app/features/general/presentation/bloc/profile/profile_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetProfileUseCase mockGetProfileUseCase;
  late ProfileBloc profileBloc;

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    profileBloc = ProfileBloc(profileUseCase: mockGetProfileUseCase);
  });
  const testProfile = ProfileEntity(
      name: 'name',
      profile: 'profile',
      zone: 'zone',
      controlSector: 'controlSector');

  test('intial state should be empty', () {
    expect(profileBloc.state, ProfileInitial());
  });

  blocTest<ProfileBloc, ProfileState>(
      'should emit [ProfileLoading, ProfileLoaded] when data is gotten',
      build: () {
        when(mockGetProfileUseCase.call())
            .thenAnswer((realInvocation) async => const Right(testProfile));
        return profileBloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [
            ProfileLoadingState(),
            const ProfileLoadedState(profile: testProfile)
          ]);

  blocTest('should emit [LoginLoading, LoginFailure] when data is unsuccessful',
      build: () {
        when(mockGetProfileUseCase.call())
            .thenAnswer((realInvocation) async => Left(ServerFailure()));
        return profileBloc;
      },
      act: (bloc) => bloc.add(GetProfileEvent()),
      expect: () => [
            ProfileLoadingState(),
            const ProfileErrorState(
                message: 'Authentication failed. Invalid user or password.')
          ]);
}
