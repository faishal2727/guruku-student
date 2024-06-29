// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
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
      : super(ProfileState.initial()) {
    on<OnProfileEvent>(_onDetailProfile);
    on<OnUpdateProfileEvent>(_onUpdateProfile);
    on<OnUpdateAvatarEvent>(_onUpdateAvatar);
    on<OnReloadProfileEvent>(_onReloadProfile); 
  }
  void _onReloadProfile(OnReloadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(stateProfile: ReqStateProfile.loading));
    final token = await getAuth.execute();

    if (token!.token.isNotEmpty) {
      final result = await _profile.execute(token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateProfile: ReqStateProfile.error, message: failure.message));
        },
        (data) {
          emit(state.copyWith(
              stateProfile: ReqStateProfile.loaded,
              message: 'Sukses Get Data',
              dataProfile: data));
        },
      );
    }
  }

  _onDetailProfile(OnProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(stateProfile: ReqStateProfile.loading));
    final token = await getAuth.execute();

    if (token!.token.isNotEmpty) {
      final result = await _profile.execute(token.token);
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateProfile: ReqStateProfile.error, message: failure.message));
        },
        (data) {
          emit(state.copyWith(
              stateProfile: ReqStateProfile.loaded,
              message: 'Sukses Get Data',
              dataProfile: data));
        },
      );
    }
  }

  // update profile
  _onUpdateProfile(
      OnUpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(stateAvatar: ReqStateAvatar.loading));
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
          emit(state.copyWith(
              stateAvatar: ReqStateAvatar.error, message: failure.message));
        },
        (data) {
          debugPrint('Update Profile Success: $data');
          emit(state.copyWith(
              stateAvatar: ReqStateAvatar.loaded,
              dataAvatar: data,
              message: 'Sukses Update Profile'));
        },
      );
    }
  }

  _onUpdateAvatar(OnUpdateAvatarEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(stateAvatar: ReqStateAvatar.loading));
    final user = await getAuth.execute();

    if (user != null) {
      final result = await updateAvatar.execute(
        event.bytes,
        event.fileName,
        user.token,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(
              stateAvatar: ReqStateAvatar.error, message: failure.message));
        },
        (data) {
          emit(state.copyWith(
              stateAvatar: ReqStateAvatar.loaded,
              dataAvatar: data,
              message: 'Sukses Update Avatar'));
        },
      );
    }
  }
}
