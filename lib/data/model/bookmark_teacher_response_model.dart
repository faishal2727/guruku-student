// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/bookmark_teacher_respone.dart';

class BookmarkTeacherResponseModel extends Equatable {
  int code;
  String status;
  bool success;
  String message;

  BookmarkTeacherResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  factory BookmarkTeacherResponseModel.fromJson(Map<String, dynamic> json) =>
      BookmarkTeacherResponseModel(
        code: json["code"],
        status: json["status"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "success": success,
        "message": message,
      };

  BookmarkTeacherResponse toEntity() => BookmarkTeacherResponse(
        code: code,
        status: status,
        success: success,
        message: message,
      );

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
      ];
}
