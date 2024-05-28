part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginResponse? loginResponse;
  final RequestStateLogin? stateLogin;
  final String message;

  const LoginState({
    required this.loginResponse,
    required this.stateLogin,
    required this.message,
  });

  LoginState copyWith({
    LoginResponse? loginResponse,
    RequestStateLogin? stateLogin,
    String? message,
  }) {
    return LoginState(
      loginResponse: loginResponse ?? this.loginResponse,
      stateLogin: stateLogin ?? this.stateLogin,
      message: message ?? this.message,
    );
  }

  factory LoginState.initial() {
    return const LoginState(
      loginResponse: null,
      stateLogin: RequestStateLogin.initial,
      message: "",
    );
  }

  @override
  List<Object?> get props => [
        loginResponse,
        stateLogin,
        message,
      ];
}
