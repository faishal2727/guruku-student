import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/order_model/data_model.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';

class OrderResponseModel extends Equatable {
  final int code;
  final String status;
  final bool success;
  final String message;
  final DataModel data;

  const OrderResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
        code: json["code"],
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: DataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "success": success,
        "message": message,
        "data": data.toJson(),
      };

  OrderResponse toEntity() => OrderResponse(
        code: code,
        status: status,
        success: success,
        message: message,
        data: data.toEntity(),
      );

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
        data,
      ];
}
