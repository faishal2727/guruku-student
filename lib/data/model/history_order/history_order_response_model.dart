import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/history_order/data_history_order_model.dart';

class HistoryOrderResponseModel extends Equatable {
  final int code;
  final String status;
  final bool error;
  final String message;
  final List<DataHistoryOrderModel> data;

  const HistoryOrderResponseModel({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory HistoryOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      HistoryOrderResponseModel(
        code: json["code"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: List<DataHistoryOrderModel>.from((json["data"] as List)
            .map((x) => DataHistoryOrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson()))
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
