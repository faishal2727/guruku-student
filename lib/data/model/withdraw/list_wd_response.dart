// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/withdraw/withdraw_detail_response_model.dart';

class ListWdResponse extends Equatable {
  int code;
  String status;
  bool error;
  String message;
  List<WithdrawDetailResponseModel> data;

  ListWdResponse({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory ListWdResponse.fromJson(Map<String, dynamic> json) =>
      ListWdResponse(
        code: json["code"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: List<WithdrawDetailResponseModel>.from((json["data"] as List).map((x) => WithdrawDetailResponseModel.fromJson(x)))
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
