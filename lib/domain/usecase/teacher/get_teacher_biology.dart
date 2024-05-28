import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class GetTeacherBiology {
  final TeacherRepository repository;

  GetTeacherBiology(this.repository);

  Future<Either<Failure, List<Teacher>>> execute() async {
    return await repository.getTeacherBilogy();
  }
}
