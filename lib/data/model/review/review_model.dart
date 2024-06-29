import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/review/review.dart';

class ReviewModel extends Equatable {
  final int id;
  final int idStudent;
  final int idTeacher;
  final String rate;
  final String desc;
  final String? detail;
  final DateTime createdAt;
  final StudentModel student;
  final TeacherModel teacher;

  const ReviewModel({
    required this.id,
    required this.idStudent,
    required this.idTeacher,
    required this.rate,
    required this.desc,
    required this.detail,
    required this.createdAt,
    required this.student,
    required this.teacher,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        idStudent: json["id_student"],
        idTeacher: json["id_teacher"],
        rate: json["rate"],
        desc: json["desc"],
        detail: json["detail"] ?? "uyu",
        createdAt: DateTime.parse(json["createdAt"]),
        student: StudentModel.fromJson(json["student"]),
        teacher: TeacherModel.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_student": idStudent,
        "id_teacher": idTeacher,
        "rate": rate,
        "desc": desc,
        "detail": detail,
        "createdAt": createdAt,
        "student": student.toJson(),
        "teacher": teacher.toJson(),
      };

  Review toEntity() {
    return Review(
      id: id,
      idStudent: idStudent,
      idTeacher: idTeacher,
      rate: rate,
      desc: desc,
      detail: detail,
      createdAt: createdAt,
      student: student.toEntity(),
      teacher: teacher.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        idStudent,
        idTeacher,
        rate,
        desc,
        detail,
        createdAt,
        student,
        teacher,
      ];
}
