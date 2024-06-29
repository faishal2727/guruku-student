import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class Review extends Equatable {
  final int id;
  final int idStudent;
  final int idTeacher;
  final String rate;
  final String desc;
  final String? detail;
  final DateTime createdAt;
  final Student student;
  final Teacher teacher;

  const Review({
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
