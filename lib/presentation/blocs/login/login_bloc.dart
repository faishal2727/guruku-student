import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/auth/login_response.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/auth/login.dart';
import 'package:guruku_student/domain/usecase/auth/remove_auth.dart';
import 'package:guruku_student/domain/usecase/auth/save_auth.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final SaveAuth saveAuth;
  final GetAuth getAuth;
  final RemoveAuth removeAuth;

  LoginBloc({
    required this.login,
    required this.saveAuth,
    required this.getAuth,
    required this.removeAuth,
  }) : super(LoginState.initial()) {
    on<DoLogin>(
      (event, emit) async {
        emit(state.copyWith(stateLogin: RequestStateLogin.loading));
        final String email = event.email;
        final String password = event.password;

        final result = await login.execute(email: email, password: password);

        result.fold(
          (failure) => emit(
            state.copyWith(
              stateLogin: RequestStateLogin.error,
              message: failure.message,  
            ),
          ),
          (data) {
            saveAuth.execute(data);
            emit(
              state.copyWith(
                stateLogin: RequestStateLogin.loaded,
                loginResponse: data,
                message: data.message, 
              ),
            );
          },
        );
      },
    );

    on<DoAuthCheckEventk>(
      (event, emit) async {
        emit(state.copyWith(stateLogin: RequestStateLogin.loading));

        final auth = await getAuth.execute();
        debugPrint("CEK OY $auth");

        if (auth != null) {
          emit(state.copyWith(
              stateLogin: RequestStateLogin.loaded, loginResponse: auth, message: ''));
        } else {
          emit(state.copyWith(
              stateLogin: RequestStateLogin.error, loginResponse: null, message: ''));
        }
      },
    );

    on<DoLogoutEvent>(
      (event, emit) async {
        emit(state.copyWith(stateLogin: RequestStateLogin.loading));
        await removeAuth.execute();
        emit(
          state.copyWith(
            loginResponse: null,
            stateLogin: RequestStateLogin.empty,
            message: '',
          ),
        );
      },
    );
  }
}
