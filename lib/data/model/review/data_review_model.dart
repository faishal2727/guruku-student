import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/review/data_review.dart';

class DataReviewModel extends Equatable {
  final int id;
  final String rate;
  final String desc;
  final String? detail;
  final int idStudent;
  final int idTeacher;

  const DataReviewModel({
    required this.id,
    required this.rate,
    required this.desc,
    required this.detail,
    required this.idStudent,
    required this.idTeacher,
  });

  factory DataReviewModel.fromJson(Map<String, dynamic> json) =>
      DataReviewModel(
        id: json["id"],
        rate: json["rate"],
        desc: json["desc"],
        detail: json["detail"] ?? "",
        idStudent: json["id_student"],
        idTeacher: json["id_teacher"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rate": rate,
        "desc": desc,
        "detail": detail,
        "id_student": idStudent,
        "id_teacher": idTeacher,
      };

  DataReview toEntity() {
    return DataReview(
      id: id,
      rate: rate,
      desc: desc,
      detail: detail,
      idStudent: idStudent,
      idTeacher: idTeacher,
    );
  }

  @override
  List<Object?> get props => [
        id,
        rate,
        desc,
        detail,
        idStudent,
        idTeacher,
      ];
}
