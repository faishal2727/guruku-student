
import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/wishlist/add_wishlist_request.dart';

class AddWishlistRequestModel extends Equatable {
  final int idTeacher;

  const AddWishlistRequestModel({
    required this.idTeacher,
  });

  factory AddWishlistRequestModel.fromJson(Map<String, dynamic> json) =>
    AddWishlistRequestModel(
      idTeacher: json["id_teacher"],
    );

    Map<String, dynamic> toJson() => {
      "id_teacher": idTeacher,
    };

  factory AddWishlistRequestModel.fromEntity(AddWishlistRequest request) =>
      AddWishlistRequestModel(
        idTeacher: request.idTeacher,
      );

  @override
  List<Object?> get props => [
        idTeacher,
      ];
}
