part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final List<TokenEntity> loginList;

  const LoginSuccessState({required this.loginList});
  @override
  List<Object> get props => [loginList];
}

class LoginErrorState extends LoginState {
  final String message;
  const LoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
