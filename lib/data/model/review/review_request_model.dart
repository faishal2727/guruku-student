import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/review/review_request.dart';

class ReviewRequestModel extends Equatable {
  final int idTeacher;
  final int idOrder;
  final String rate;
  final String desc;
  final String detail;

  const ReviewRequestModel({
    required this.idTeacher,
    required this.idOrder,
    required this.rate,
    required this.desc,
    required this.detail,
  });

  factory ReviewRequestModel.fromJson(Map<String, dynamic> json) =>
      ReviewRequestModel(
          idTeacher: json["id_teacher"],
          idOrder: json["transaksi_id"],
          rate: json["rate"],
          desc: json["desc"],
          detail: json["detail"]);

  Map<String, dynamic> toJson() => {
        "id_teacher": idTeacher,
        "transaksi_id": idOrder,
        "rate": rate,
        "desc": desc,
        "detail": detail,
      };

  factory ReviewRequestModel.fromEntity(ReviewRequest request) =>
      ReviewRequestModel(
        idTeacher: request.idTeacher,
        idOrder: request.idOrder,
        rate: request.rate,
        desc: request.desc,
        detail: request.detail,
      );

  @override
  List<Object?> get props => [
        idTeacher,
        rate,
        desc,
        detail,
      ];
}
