part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class DoLogin extends LoginEvent {
  final String email;
  final String password;

  const DoLogin({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

final class DoAuthCheckEventk extends LoginEvent {}

final class DoLogoutEvent extends LoginEvent {}

