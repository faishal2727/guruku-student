part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginResponse? loginResponse;
  final RequestStateLogin? stateLogin;
  final String message;
  final String role;

  const LoginState({
    required this.loginResponse,
    required this.stateLogin,
    required this.message,
    required this.role,
  });

  LoginState copyWith({
    LoginResponse? loginResponse,
    RequestStateLogin? stateLogin,
    String? message,
    String? role,
  }) {
    return LoginState(
      loginResponse: loginResponse ?? this.loginResponse,
      stateLogin: stateLogin ?? this.stateLogin,
      message: message ?? this.message,
      role: role ?? this.role,
    );
  }

  factory LoginState.initial() {
    return const LoginState(
      loginResponse: null,
      stateLogin: RequestStateLogin.initial,
      message: "",
      role: ""
    );
  }

  @override
  List<Object?> get props => [
        loginResponse,
        stateLogin,
        message,
      ];
}
