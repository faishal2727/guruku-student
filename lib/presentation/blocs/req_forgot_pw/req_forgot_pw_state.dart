part of 'req_forgot_pw_bloc.dart';

class ReqForgotPwState extends Equatable {
  final ReqForgotPwResponse? reqForgotPwData;
  final String message;
  final RequestStateReqForgotPw stateReq;

  const ReqForgotPwState({
    required this.reqForgotPwData,
    required this.message,
    required this.stateReq,
  });

  ReqForgotPwState copyWith({
    ReqForgotPwResponse? reqForgotPwData,
    String? message,
    RequestStateReqForgotPw? stateReq,
  }) {
    return ReqForgotPwState(
      reqForgotPwData: reqForgotPwData ?? this.reqForgotPwData,
      message: message ?? this.message,
      stateReq: stateReq ?? this.stateReq,
    );
  }

  factory ReqForgotPwState.initial() {
    return const ReqForgotPwState(
      reqForgotPwData: null,
      message: " ",
      stateReq: RequestStateReqForgotPw.initial,
    );
  }

  @override
  List<Object?> get props => [
        reqForgotPwData,
        message,
        stateReq,
      ];
}
