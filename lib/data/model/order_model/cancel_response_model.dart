
import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/order/cancel_response.dart';

class CancelResponseModel extends Equatable {
  final int code;
  final String status;
  final bool success;
  final String message;

  const CancelResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  factory CancelResponseModel.fromJson(Map<String, dynamic> json) =>
      CancelResponseModel(
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

  CancelResponse toEntity() => CancelResponse(
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
