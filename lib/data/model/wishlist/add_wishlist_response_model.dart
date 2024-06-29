import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/wishlist/add_wishlist_response.dart';

class AddWislistResponseModel extends Equatable {
  final int code;
  final String status;
  final bool success;
  final String message;

  const AddWislistResponseModel({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  factory AddWislistResponseModel.fromJson(Map<String, dynamic> json) =>
      AddWislistResponseModel(
        code: json["code"],
        status: json["status"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "success": success,
        "message": message,
      };

  AddWislistResponse toEntity() {
    return AddWislistResponse(
      code: code,
      status: status,
      success: success,
      message: message,
    );
  }

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
      ];
}
