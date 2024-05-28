part of 'forgot_pw_bloc.dart';

class ForgotPwState extends Equatable {
  final ForgotPwResponse? forgotPwData;
  final String message;
  final RequestStateForgotPw stateForgot;

  const ForgotPwState({
    required this.forgotPwData,
    required this.message,
    required this.stateForgot,
  });

  ForgotPwState copyWith({
    ForgotPwResponse? forgotPwData,
    String? message,
    RequestStateForgotPw? stateForgotPw,
  }) {
    return ForgotPwState(
      forgotPwData: forgotPwData ?? this.forgotPwData,
      message: message ?? this.message,
      stateForgot: stateForgot,
    );
  }

  factory ForgotPwState.initial() {
    return const ForgotPwState(
      forgotPwData: null,
      message: "",
      stateForgot: RequestStateForgotPw.initial,
    );
  }

  @override
  List<Object?> get props => [
        forgotPwData,
        message,
        stateForgot,
      ];
}
