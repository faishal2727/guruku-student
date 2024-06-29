// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/wishlist/wishlist.dart';

class WishlistModel extends Equatable {
  int idTeacher;
  int idUser;
  TeacherModel teacher;

  WishlistModel({
    required this.idTeacher,
    required this.idUser,
    required this.teacher,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
        idTeacher: json["id_teacher"],
        idUser: json["id_user"],
        teacher: TeacherModel.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id_teacher": idTeacher,
        "id_user": idUser,
        "teacher": teacher.toJson(),
      };

  Wishlist toEntity() {
    return Wishlist(
      idTeacher: idTeacher,
      idUser: idUser,
      teacher: teacher.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        idTeacher,
        idUser,
        teacher,
      ];
}
