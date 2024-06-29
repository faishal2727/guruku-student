// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class Wishlist extends Equatable {
  int idTeacher;
  int idUser;
  Teacher teacher;

  Wishlist({
    required this.idTeacher,
    required this.idUser,
    required this.teacher,
  });

  @override
  List<Object?> get props => [
        idTeacher,
        idUser,
        teacher,
      ];
}
