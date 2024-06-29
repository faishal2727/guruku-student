import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';

abstract class MyDataTeacherRepository {
  Future<Either<Failure, MyDataTeacherResponse>> getMyDataTeacher(String token, int id);
}