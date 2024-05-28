import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class GetSearchTeacher {
  final TeacherRepository repository;

  GetSearchTeacher(this.repository);

  Future<Either<Failure, List<Teacher>>> execute(String query) {
    return repository.getSearchTeacher(query);
  }
}