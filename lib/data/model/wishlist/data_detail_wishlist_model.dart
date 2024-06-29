// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/wishlist/data_detail_wishlist.dart';

class DataDetailWishlistModel extends Equatable {
  int idTeacher;
  int idUser;
  StudentModel student;
  TeacherModel teacher;

  DataDetailWishlistModel({
    required this.idTeacher,
    required this.idUser,
    required this.student,
    required this.teacher,
  });

  factory DataDetailWishlistModel.fromJson(Map<String, dynamic> json) =>
      DataDetailWishlistModel(
        idTeacher: json["id_teacher"],
        idUser: json["id_user"],
        student: StudentModel.fromJson(json["student"]),
        teacher: TeacherModel.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id_teacher": idTeacher,
        "id_user": idUser,
        "student": student.toJson(),
        "teacher": teacher.toJson(),
      };

  DataDetailWishlist toEntity() {
    return DataDetailWishlist(
      idTeacher: idTeacher,
      idUser: idUser,
      student: student.toEntity(),
      teacher: teacher.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        idTeacher,
        idUser,
        student,
        teacher,
      ];
}
