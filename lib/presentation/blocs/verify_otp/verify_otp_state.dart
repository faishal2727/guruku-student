part of 'verify_otp_bloc.dart';

class VerifyOtpState extends Equatable {
  final VerifyOtpResponse? otpData;
  final String message;
  final RequestStateVerifyOtp stateVerifyOtp;

  const VerifyOtpState({
    required this.otpData,
    required this.message,
    required this.stateVerifyOtp,
  });

  VerifyOtpState copyWith({
    VerifyOtpResponse? otpData,
    String? message,
    RequestStateVerifyOtp? stateVerifyOtp,
  }) {
    return VerifyOtpState(
      otpData: otpData ?? this.otpData,
      message: message ?? this.message,
      stateVerifyOtp: stateVerifyOtp ?? this.stateVerifyOtp,
    );
  }

  factory VerifyOtpState.initial() {
    return const VerifyOtpState(
      otpData: null,
      message: " ",
      stateVerifyOtp: RequestStateVerifyOtp.initial,
    );
  }
  
  @override

  List<Object?> get props => [
    otpData,
    message,
    stateVerifyOtp,
  ];
}
