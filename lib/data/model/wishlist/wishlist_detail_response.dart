import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/wishlist/data_detail_wishlist_model.dart';
import 'package:guruku_student/domain/entity/wishlist/wishlist_detail_response.dart';

class WishlistDetailResponseModel extends Equatable {
  final int code;
  final String status;
  final bool error;
  final String message;
  final DataDetailWishlistModel data;

  const WishlistDetailResponseModel({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  factory WishlistDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      WishlistDetailResponseModel(
        code: json["code"],
        status: json["status"],
        error: json["error"],
        message: json["message"],
        data: DataDetailWishlistModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "error": error,
        "message": message,
        "data": data.toJson(),
      };

  WishlistDetailResponse toEntity() {
    return WishlistDetailResponse(
      code: code,
      status: status,
      error: error,
      message: message,
      data: data.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        code,
        error,
        message,
        data,
      ];
}
