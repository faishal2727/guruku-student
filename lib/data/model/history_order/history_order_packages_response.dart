
import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/history_order/data_history_order_packages_model.dart';

class HistoryOrderPackagesResponse extends Equatable {
  final int code;
  final String status;
  final bool success;
  final String message;
  final List<DataHistoryOrderPackagesModel> data;

  const HistoryOrderPackagesResponse({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory HistoryOrderPackagesResponse.fromJson(Map<String, dynamic> json) =>
      HistoryOrderPackagesResponse(
        code: json["code"],
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: List<DataHistoryOrderPackagesModel>.from((json["data"] as List)
            .map((x) => DataHistoryOrderPackagesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson()))
      };

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
        data,
      ];
}
