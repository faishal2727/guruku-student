import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/register_teacher/add_data_teacher_response.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class PickSchedule {
  final TeacherRepository repository;

  PickSchedule(this.repository);

  Future<Either<Failure, AddDataTeacherResponse>> execute(
      String token,  List<Map<String, dynamic>> schedule,) async {
    return repository.pickSchedule(token, schedule);
  }
}
