// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_request.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/profile/detail_profile.dart';
import 'package:guruku_student/domain/usecase/profile/update_avatar.dart';

import '../../../domain/usecase/profile/update_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DetailProfile _profile;
  final UpdateProfile updateProfile;
  final GetAuth getAuth;
  final UpdateAvatar updateAvatar;

  ProfileBloc(
      this._profile, this.getAuth, this.updateProfile, this.updateAvatar)
      : super(ProfileEmpty()) {
    on<OnProfileEvent>(_onDetailProfile);
    on<OnUpdateProfileEvent>(_onUpdateProfile);
    on<OnUpdateAvatarEvent>(_onUpdateAvatar);
  }

  _onDetailProfile(OnProfileEvent event, Emitter<ProfileState> state) async {
    emit(ProfileLoading());
    final token = await getAuth.execute();

    if (token!.token.isNotEmpty) {
      final result = await _profile.execute(token.token);
      result.fold(
        (failure) {
          emit(ProfileError(failure.message));
        },
        (data) {
          emit(ProfileHasData(data));
        },
      );
    }
  }

  // update profile
  _onUpdateProfile(
      OnUpdateProfileEvent event, Emitter<ProfileState> state) async {
    emit(ProfileLoading());
    final user = await getAuth.execute();

    if (user != null) {
      final request = UpdateProfileRequest(
        username: event.username,
        name: event.name,
        email: event.email,
        phone: event.phone,
        education: event.education,
        address: event.address,
        bod: event.bod,
        lat: event.lat,
        lon: event.lon,
      );
      debugPrint('Update Profile Request: $request');
      debugPrint('User Token: ${user.token}');

      final result = await updateProfile.execute(
        updateProfile: request,
        token: user.token,
      );
      result.fold(
        (failure) {
          debugPrint('Update Profile Error: ${failure.message}');
          emit(ProfileError(failure.message));
        },
        (data) {
          debugPrint('Update Profile Success: $data');
          emit(UpdateProfileSuccess(result: data));
        },
      );
    }
  }

  _onUpdateAvatar(OnUpdateAvatarEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final user = await getAuth.execute();

    if (user != null) {
      final result = await updateAvatar.execute(
        event.bytes,
        event.fileName,
        user.token,
      );
      result.fold(
        (failure) {
          emit(UpdateAvatarError(failure.message));
        },
        (data) {
          emit(UpdateAvatarSuccess(result: data));
        },
      );
    }
  }
}
