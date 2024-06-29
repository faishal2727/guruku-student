
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/wishlist/wishlist_model.dart';

class WishlistResponseModel extends Equatable {
  int code;
  String status;
  bool success;
  String message;
  List<WishlistModel> data;

  WishlistResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) =>
      WishlistResponseModel(
        code: json["code"],
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: List<WishlistModel>.from((json["data"] as List).map((x) => WishlistModel.fromJson(x)))
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
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
