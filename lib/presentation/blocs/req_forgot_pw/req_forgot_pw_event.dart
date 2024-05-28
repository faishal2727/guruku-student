part of 'req_forgot_pw_bloc.dart';

abstract class ReqForgotPwEvent extends Equatable {
  const ReqForgotPwEvent();

  @override
  List<Object> get props => [];
}

class DoReqForgotPw extends ReqForgotPwEvent {
  final String email;

  const DoReqForgotPw({
    required this.email,
  });
}
