
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/notif/notif_response_model.dart';

class ResponseNotif extends Equatable {
  int code;
  String status;
  bool error;
  String message;
  List<NotifResponseModel> data;

  ResponseNotif({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory ResponseNotif.fromJson(Map<String, dynamic> json) =>
      ResponseNotif(
        code: json["code"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: List<NotifResponseModel>.from((json["data"] as List).map((x) => NotifResponseModel.fromJson(x)))
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
