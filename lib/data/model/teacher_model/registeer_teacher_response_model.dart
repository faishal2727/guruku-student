import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/dataku.dart';
import 'package:guruku_student/domain/entity/register_teacher/register_teacher_response.dart';

class RegisterTeacherResponseModel extends Equatable {
  final int code;
  final bool error;
  final String status;
  final Dataku data;

  const RegisterTeacherResponseModel({
    required this.code,
    required this.error,
    required this.status,
    required this.data,
  });

  factory RegisterTeacherResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterTeacherResponseModel(
          code: json["code"],
          error: json["error"],
          status: json["status"],
          data: Dataku.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "status": status,
        "data": data.toJson(),
      };

  RegisterTeacherResponse toEntity() => RegisterTeacherResponse(
        code: code,
        error: error,
        status: status,
        data: data.toEntity(),
      );

  factory RegisterTeacherResponseModel.fromEntity(
          RegisterTeacherResponse data) =>
      RegisterTeacherResponseModel(
        code: data.code,
        error: data.error,
        status: data.status,
        data: Dataku.fromEntity(data.data),
      );

  @override
  List<Object?> get props => [code, error, status, data];
}
