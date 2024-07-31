// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_response.dart';

class WithdrawResponseModel extends Equatable {
  int code;
  String status;
  bool success;
  String message;

  WithdrawResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  factory WithdrawResponseModel.fromJson(Map<String, dynamic> json) =>
      WithdrawResponseModel(
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

  WithdrawResponse toEntity() {
    return WithdrawResponse(
      code: code,
      status: status,
      success: success,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
      ];
}
