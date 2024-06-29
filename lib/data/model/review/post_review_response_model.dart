// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/review/post_review_response.dart';

class PostReviewResponseModel extends Equatable {
  int code;
  bool error;
  String message;
  // DataReviewModel data;

  PostReviewResponseModel({
    required this.code,
    required this.error,
    required this.message,
    // required this.data,
  });

  factory PostReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      PostReviewResponseModel(
        code: json["code"],
        error: json["error"],
        message: json["message"],
        // data: DataReviewModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "error": error,
        "message": message,
        // "data": data.toJson(),
      };

  PostReviewResponse toEntity() {
    return PostReviewResponse(
      code: code,
      error: error,
      message: message,
      // data: data.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        code,
        error,
        message,
        // data,
      ];
}
