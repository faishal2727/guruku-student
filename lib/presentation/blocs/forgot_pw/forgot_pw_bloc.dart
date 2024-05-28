import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/auth/forgot_pw_response.dart';
import 'package:guruku_student/domain/usecase/auth/forgot_password.dart';

part 'forgot_pw_event.dart';
part 'forgot_pw_state.dart';

class ForgotPwBloc extends Bloc<ForgotPwEvent, ForgotPwState> {
  final ForgotPassword forgotPassword;

  ForgotPwBloc({required this.forgotPassword})
      : super(ForgotPwState.initial()) {
    on<DoForgotPw>(
      (event, emit) async {
        emit(state.copyWith(stateForgotPw: RequestStateForgotPw.loading));
        final String email = event.email;
        final String password = event.password;

        final result =
            await forgotPassword.execute(email: email, password: password);

        result.fold(
          (failure) =>
              emit(state.copyWith(stateForgotPw: RequestStateForgotPw.error)),
          (data) {
            emit(
              state.copyWith(
                  stateForgotPw: RequestStateForgotPw.loaded,
                  forgotPwData: data,
                  message: "Berhasil Ubah Password"),
            );
          },
        );
      },
    );
  }
}
