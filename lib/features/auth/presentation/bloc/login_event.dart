part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginCheckEvent extends LoginEvent {
  final String email;
  final String password;
  const LoginCheckEvent({required this.email, required this.password});
}
