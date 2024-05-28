part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final RegisterResponse? registerData;
  final String message;
  final RequestStateRegister stateRegister;

  const RegisterState({
    required this.registerData,
    required this.message,
    required this.stateRegister,
  });

  RegisterState copyWith({
    RegisterResponse? registerData,
    String? message,
    RequestStateRegister? stateRegister,
  }) {
    return RegisterState(
      registerData: registerData ?? this.registerData,
      message: message ?? this.message,
      stateRegister: stateRegister ?? this.stateRegister,
    );
  }

  factory RegisterState.initial() {
    return const RegisterState(
      registerData: null,
      message: " ",
      stateRegister: RequestStateRegister.initial,
    );
  }

  @override
  List<Object?> get props => [
        registerData,
        message,
        stateRegister,
      ];
}
