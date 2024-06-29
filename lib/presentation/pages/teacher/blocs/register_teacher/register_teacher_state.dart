part of 'register_teacher_bloc.dart';


class RegisterTeacherState extends Equatable {
  final RegisterTeacherResponse? registerData;
  final String message;
  final ReqStateRegisTeacher stateRegister;

  const RegisterTeacherState({
    required this.registerData,
    required this.message,
    required this.stateRegister,
  });

  RegisterTeacherState copyWith({
    RegisterTeacherResponse? registerData,
    String? message,
    ReqStateRegisTeacher? stateRegister,
  }) {
    return RegisterTeacherState(
      registerData: registerData ?? this.registerData,
      message: message ?? this.message,
      stateRegister: stateRegister ?? this.stateRegister,
    );
  }

  factory RegisterTeacherState.initial() {
    return const RegisterTeacherState(
      registerData: null,
      message: " ",
      stateRegister: ReqStateRegisTeacher.initial,
    );
  }

  @override
  List<Object?> get props => [
        registerData,
        message,
        stateRegister,
      ];
}
