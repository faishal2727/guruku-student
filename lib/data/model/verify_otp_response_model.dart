// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/verify_otp_response.dart';

class VerifyOtpResponseModel extends Equatable {
  int code;
  String status;
  bool success;
  String message;

  VerifyOtpResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponseModel(
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

  VerifyOtpResponse toEntity() => VerifyOtpResponse(
        code: code,
        status: status,
        success: success,
        message: message,
      );

  factory VerifyOtpResponseModel.fromEntity(VerifyOtpResponse data) =>
      VerifyOtpResponseModel(
        code: data.code,
        status: data.status,
        success: data.success,
        message: data.message,
      );

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
      ];
}
