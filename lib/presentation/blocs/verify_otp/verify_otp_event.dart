part of 'verify_otp_bloc.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class DoVerifyOtpEvent extends VerifyOtpEvent {
  final String email;
  final String otp;

  const DoVerifyOtpEvent({
    required this.email,
    required this.otp,
  });
}
