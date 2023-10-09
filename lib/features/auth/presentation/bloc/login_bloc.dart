import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/core/error/failures.dart';
import 'package:login_app/core/strings/error.dart';
import 'package:login_app/features/auth/domain/entities/token_entity.dart';
import 'package:login_app/features/auth/domain/usecase/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginEvent>(
      (event, emit) async {
        if (event is LoginCheckEvent) {
          emit(LoginLoadingState());
          final failureOrLogin =
              await loginUseCase(event.email, event.password);
          failureOrLogin.fold((failure) {
            emit(LoginErrorState(message: _mapFailureToMessage(failure)));
          }, (login) {
            emit(LoginSuccessState(loginList: login));
          });
        }
      },
    );
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
