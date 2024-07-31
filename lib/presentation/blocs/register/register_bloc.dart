import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/auth/register_response.dart';

import '../../../domain/usecase/auth/register.dart';

part 'register_event.dart';
part 'regsiter_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;

  RegisterBloc({required this.register}) : super(RegisterState.initial()) {
    on<DoRegister>(
      (event, emit) async {
        emit(state.copyWith(stateRegister: RequestStateRegister.loading));
        final String username = event.username;
        final String email = event.email;
        final String password = event.password;
        final String role = event.role;

        final result = await register.execute(
            username: username, email: email, password: password, role: role);
        result.fold(
            (failure) =>
                emit(state.copyWith(stateRegister: RequestStateRegister.error)),
            (data) {
          debugPrint("KODEKU $data");
          emit(state.copyWith(
              stateRegister: RequestStateRegister.loaded,
              registerData: data,
              message: "Berhasil Register"));
        });
      },
    );
  }
}
