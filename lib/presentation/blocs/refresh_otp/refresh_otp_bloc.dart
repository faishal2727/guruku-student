import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/auth/refresh_otp.dart';
import 'package:guruku_student/domain/usecase/auth/refresh_otp.dart';

part 'refresh_otp_event.dart';
part 'refresh_otp_state.dart';

class RefreshOtpBloc extends Bloc<RefreshOtpEvent, RefreshOtpState> {
  final RefreshOtp refreshOtp;

  RefreshOtpBloc({
    required this.refreshOtp,
  }) : super(RefreshOtpState.initial()) {
    on<DorefreshOtp>(
      (event, emit) async {
        emit(state.copyWith(stateRefresh: RequestStateRefreshOtp.loading));
        final String email = event.email;

        final result = await refreshOtp.execute(email: email);

        result.fold(
          (failure) {
            debugPrint("Failure: ${failure.toString()}");
            emit(state.copyWith(stateRefresh: RequestStateRefreshOtp.error));
          },
          (data) {
            debugPrint("Success: ${data.data}");
            emit(
              state.copyWith(
                stateRefresh: RequestStateRefreshOtp.loaded,
                refreshOtpData: data,
                message: "Berhasil Kirim Ulang OTP",
              ),
            );
          },
        );
      },
    );
  }
}
