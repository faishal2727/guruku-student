// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class DataDetailWishlist extends Equatable {
  int idTeacher;
  int idUser;
  Student student;
  Teacher teacher;

  DataDetailWishlist({
    required this.idTeacher,
    required this.idUser,
    required this.student,
    required this.teacher,
  });

  @override
  List<Object?> get props => [
        idTeacher,
        idUser,
        student,
        teacher,
      ];
}
