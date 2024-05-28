part of 'refresh_otp_bloc.dart';

abstract class RefreshOtpEvent extends Equatable {
  const RefreshOtpEvent();

  @override
  List<Object> get props => [];
}

class DorefreshOtp extends RefreshOtpEvent {
  final String email;

  const DorefreshOtp({
    required this.email,
  });
}
