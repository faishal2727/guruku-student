import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/bookmark_teacher_respone.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class AddTeacherBookmark {
  final TeacherRepository repository;

  AddTeacherBookmark(this.repository);

  Future<Either<Failure, BookmarkTeacherResponse>> execute(
    int idStudent,
    int idTeacher,
    String token,
  ) {
    return repository.addTeacherToBookmark(
      idStudent,
      idTeacher,
      token,
    );
  }
}
