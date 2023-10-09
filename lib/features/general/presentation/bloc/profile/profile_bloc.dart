import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/core/strings/error.dart';
import 'package:login_app/features/general/domain/entities/profile_entity.dart';
import 'package:login_app/features/general/domain/usercase/get_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase profileUseCase;
  ProfileBloc({required this.profileUseCase}) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfileEvent) {
        emit(ProfileLoadingState());
        final failureOrProfile = await profileUseCase();

        failureOrProfile.fold((failure) {
          emit(ProfileErrorState(message: _mapFailureToMessage(failure)));
        }, (profile) {
          emit(ProfileLoadedState(profile: profile));
        });
      } else if (event is RefreshProfileEvent) {
        final failureOrProfile = await profileUseCase();
        failureOrProfile.fold((failure) {
          emit(ProfileErrorState(message: _mapFailureToMessage(failure)));
        }, (profile) {
          emit(ProfileLoadedState(profile: profile));
        });
      }
    });
  }
  _mapFailureToMessage(
    Failure failure,
  ) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return "Unexpected Error, Please try again later";
    }
  }
}
