
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/packages_response.dart';

class AddPackagesResponseModel extends Equatable {
  int code;
  bool error;
  String message;
  // DataReviewModel data;

  AddPackagesResponseModel({
    required this.code,
    required this.error,
    required this.message,
    // required this.data,
  });

  factory AddPackagesResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPackagesResponseModel(
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

  PackagesResponse toEntity() {
    return PackagesResponse(
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
