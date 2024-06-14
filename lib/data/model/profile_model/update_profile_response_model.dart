// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';

class UpdateProfileResponseModel extends Equatable {
  int code;
  String status;
  bool error;
  String message;

  UpdateProfileResponseModel({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponseModel(
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

  UpdateProfileResponse toEntity() => UpdateProfileResponse(
        code: code,
        status: status,
        error: error,
        message: message,
      );

  factory UpdateProfileResponseModel.fromEntity(UpdateProfileResponse data) =>
      UpdateProfileResponseModel(
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
