// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/packages_model.dart';

class PackagesResponseModel extends Equatable {
  int code;
  String status;
  bool error;
  String message;
  List<PackagesModel> data;

  PackagesResponseModel({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory PackagesResponseModel.fromJson(Map<String, dynamic> json) =>
      PackagesResponseModel(
          code: json["code"],
          status: json["status"],
          error: json["error"],
          message: json["message"],
          data: List<PackagesModel>.from(
              (json["data"] as List).map((x) => PackagesModel.fromJson(x))));

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
