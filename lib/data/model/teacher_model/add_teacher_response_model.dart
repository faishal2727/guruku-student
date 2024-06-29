
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/register_teacher/add_data_teacher_response.dart';

class AddTeacherResponseModel extends Equatable {
  int code;
  String status;
  bool error;
  String message;

  AddTeacherResponseModel({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
  });

  factory AddTeacherResponseModel.fromJson(Map<String, dynamic> json) =>
      AddTeacherResponseModel(
        code: json["code"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "error": error,
        "message": message,
      };

  AddDataTeacherResponse toEntity() => AddDataTeacherResponse(
        code: code,
        status: status,
        error: error,
        message: message,
      );

  factory AddTeacherResponseModel.fromEntity(AddDataTeacherResponse data) =>
      AddTeacherResponseModel(
        code: data.code,
        status: data.status,
        error: data.error,
        message: data.message,
      );

  @override
  List<Object?> get props => [
        code,
        status,
        error,
        message,
      ];
}