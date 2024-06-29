// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/review/review_model.dart';

class ReviewResponseModel extends Equatable {
  int code;
  String status;
  bool error;
  String message;
  List<ReviewModel> data;

  ReviewResponseModel({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory ReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      ReviewResponseModel(
          code: json["code"],
          status: json["status"],
          error: json["error"],
          message: json["message"],
          data: List<ReviewModel>.from(
              (json["data"] as List).map((x) => ReviewModel.fromJson(x))));

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
