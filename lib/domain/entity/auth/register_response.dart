import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';

class RegisterResponse extends Equatable {
  final bool error;
  final String message;
  final Student student;

  const RegisterResponse({
    required this.error,
    required this.message,
    required this.student,
  });

  @override
  List<Object?> get props => [
        error,
        message,
        student,
      ];
}
