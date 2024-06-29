part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class DoRegister extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String role;

  const DoRegister({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });
}
