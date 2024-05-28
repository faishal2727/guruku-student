import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/auth/req_forgot_pw_response.dart';
import 'package:guruku_student/domain/usecase/auth/req_forgot_password.dart';

part 'req_forgot_pw_event.dart';
part 'req_forgot_pw_state.dart';

class ReqForgotPwBloc extends Bloc<ReqForgotPwEvent, ReqForgotPwState> {
  final ReqForgotPassword reqForgotPassword;

  ReqForgotPwBloc({
    required this.reqForgotPassword,
  }) : super(ReqForgotPwState.initial()) {
    on<DoReqForgotPw>(
      (event, emit) async {
        emit(state.copyWith(stateReq: RequestStateReqForgotPw.loading));
        final String email = event.email;

        final result = await reqForgotPassword.execute(email: email);

        result.fold(
          (failure) {
            debugPrint("Failure: ${failure.toString()}");
            emit(state.copyWith(stateReq: RequestStateReqForgotPw.error));
          },
          (data) {
            debugPrint("Success: ${data.data}");
            emit(
              state.copyWith(
                stateReq: RequestStateReqForgotPw.loaded,
                reqForgotPwData: data,
                message: "Berhasil Kirim Email Req Forgot Pw",
              ),
            );
          },
        );
      },
    );
  }
}

