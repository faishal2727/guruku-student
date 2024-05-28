import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/student_model.dart';
import 'package:guruku_student/domain/entity/auth/register_response.dart';

class RegisterResponseModel extends Equatable {
  final bool error;
  final String message;
  final StudentModel student;

  const RegisterResponseModel({
    required this.error,
    required this.message,
    required this.student,
  });

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'student': student.toJson(),
      };

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        error: json['error'],
        message: json['message'],
        student: StudentModel.fromJson(json["student"]),
      );

  RegisterResponse toEntity() => RegisterResponse(
        error: error,
        message: message,
        student: student.toEntity(), 
      );

  factory RegisterResponseModel.fromEntity(RegisterResponse data) =>
      RegisterResponseModel(
        error: data.error,
        message: data.message,
        student: StudentModel.fromEntity(data.student),
      );

  @override
  List<Object?> get props => [
        error,
        message,
        student,
      ];
}
