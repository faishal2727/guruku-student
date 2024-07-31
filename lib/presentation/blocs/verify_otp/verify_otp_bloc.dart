import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/auth/verify_otp_response.dart';
import 'package:guruku_student/domain/usecase/auth/verify_otp.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtp verifyOtp;

  VerifyOtpBloc({required this.verifyOtp}) : super(VerifyOtpState.initial()) {
    on<DoVerifyOtpEvent>(
      (event, emit) async {
        emit(state.copyWith(stateVerifyOtp: RequestStateVerifyOtp.loading));
        final String email = event.email;
        final String otp = event.otp;
        final result = await verifyOtp.execute(email: email, otp: otp);
        result.fold(
            (failure) => emit(
                state.copyWith(stateVerifyOtp: RequestStateVerifyOtp.error)),
            (data) {
          emit(state.copyWith(
              stateVerifyOtp: RequestStateVerifyOtp.loaded,
              otpData: data,
              message: "Berhasil Verify Otp"));
        });
      },
    );
  }
}
