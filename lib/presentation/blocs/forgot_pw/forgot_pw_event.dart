part of 'forgot_pw_bloc.dart';

abstract class ForgotPwEvent extends Equatable {
  const ForgotPwEvent();
  @override
  List<Object> get props => [];
}

class DoForgotPw extends ForgotPwEvent {
  final String email;
  final String password;

  const DoForgotPw({
    required this.email,
    required this.password,
  });
}
