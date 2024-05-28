import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class SaveBookmarkTeacher {
  final TeacherRepository repository;

  SaveBookmarkTeacher(this.repository);

  Future<Either<Failure, String>> execute(TeacherDetail teacher) {
    return repository.saveBookmarkTeacher(teacher);
  }
}