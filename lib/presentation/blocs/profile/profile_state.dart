// ignore_for_file: prefer_const_constructors_in_immutables

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object> get props => [];
}

class ProfileHasData extends ProfileState {
  final DetailProfileResponse result;

  ProfileHasData(this.result);

  @override
  List<Object> get props => [];
}

class UpdateProfileSuccess extends ProfileState {
  final UpdateProfileResponse result;

  const UpdateProfileSuccess({required this.result});
  @override
  List<Object> get props => [result];
}

class ProfileEmpty extends ProfileState {
  @override
  List<Object> get props => [];
}

// Update Avatar

class UpdateAvatarError extends ProfileState {
  final String message;

  UpdateAvatarError(this.message);

  @override
  List<Object> get props => [];
}

class UpdateAvatarSuccess extends ProfileState {
  final UpdateProfileResponse result;

  const UpdateAvatarSuccess({required this.result});

  @override
  List<Object> get props => [result];
}
