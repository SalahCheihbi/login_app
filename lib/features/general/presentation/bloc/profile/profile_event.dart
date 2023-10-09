part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class RefreshProfileEvent extends ProfileEvent {
  final bool dataAdded;
  const RefreshProfileEvent({required this.dataAdded});
}
