import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/domain/repositories/my_data_teacher_repository.dart';

class GetMyDataTeacher {
  final MyDataTeacherRepository repository;

  GetMyDataTeacher(this.repository);

  Future<Either<Failure, MyDataTeacherResponse>> execute({
    required String token,
    required int id,
  }) async {
    return repository.getMyDataTeacher(token, id);
  }
}
