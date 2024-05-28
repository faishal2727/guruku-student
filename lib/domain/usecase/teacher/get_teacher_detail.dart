import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class GetTeaacherDetail {
  final TeacherRepository repository;

  GetTeaacherDetail(this.repository);

  Future<Either<Failure, TeacherDetail>> execute(int id) {
    return repository.getTeacherDetail(id);
  }
}
