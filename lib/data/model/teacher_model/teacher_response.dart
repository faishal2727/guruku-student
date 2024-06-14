// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';

class TeacherResponse extends Equatable {
  int code;
  String status;
  bool error;
  String message;
  List<TeacherModel> data;

  TeacherResponse({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory TeacherResponse.fromJson(Map<String, dynamic> json) =>
      TeacherResponse(
        code: json["code"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: List<TeacherModel>.from((json["data"] as List).map((x) => TeacherModel.fromJson(x)))
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        code,
        status,
        error,
        message,
        data,
      ];
}
