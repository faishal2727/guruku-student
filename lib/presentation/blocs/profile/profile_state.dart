// ignore_for_file: prefer_const_constructors_in_immutables

part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final DetailProfileResponse? dataProfile;
  final UpdateProfileResponse? dataAvatar;
  final String message;
  final ReqStateProfile stateProfile;
  final ReqStateAvatar stateAvatar;

  const ProfileState({
    required this.dataProfile,
    required this.dataAvatar,
    required this.message,
    required this.stateProfile,
    required this.stateAvatar,
  });

  ProfileState copyWith({
    DetailProfileResponse? dataProfile,
    UpdateProfileResponse? dataAvatar,
    String? message,
    ReqStateProfile? stateProfile,
    ReqStateAvatar? stateAvatar,
  }) {
    return ProfileState(
      dataProfile: dataProfile ?? this.dataProfile,
      dataAvatar: dataAvatar ?? this.dataAvatar,
      message: message ?? this.message,
      stateProfile: stateProfile ?? this.stateProfile,
      stateAvatar: stateAvatar ?? this.stateAvatar,
    );
  }

  factory ProfileState.initial() {
    return const ProfileState(
      dataProfile: null,
      dataAvatar: null,
      message: '',
      stateProfile: ReqStateProfile.initial,
      stateAvatar: ReqStateAvatar.initial,
    );
  }

  @override
  List<Object?> get props => [
        dataProfile,
        dataAvatar,
        message,
        stateProfile,
        stateProfile,
      ];
}
// abstract class ProfileState extends Equatable {
//   const ProfileState();
//   @override
//   List<Object> get props => [];
// }

// class ProfileLoading extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

// class ProfileError extends ProfileState {
//   final String message;

//   ProfileError(this.message);

//   @override
//   List<Object> get props => [];
// }

// class ProfileHasData extends ProfileState {
//   final DetailProfileResponse result;

//   ProfileHasData(this.result);

//   @override
//   List<Object> get props => [];
// }

// class UpdateProfileSuccess extends ProfileState {
//   final UpdateProfileResponse result;

//   const UpdateProfileSuccess({required this.result});
//   @override
//   List<Object> get props => [result];
// }

// class ProfileEmpty extends ProfileState {
//   @override
//   List<Object> get props => [];
// }

// // Update Avatar

// class UpdateAvatarError extends ProfileState {
//   final String message;

//   UpdateAvatarError(this.message);

//   @override
//   List<Object> get props => [];
// }

// class UpdateAvatarSuccess extends ProfileState {
//   final UpdateProfileResponse result;

//   const UpdateAvatarSuccess({required this.result});

//   @override
//   List<Object> get props => [result];
// }
