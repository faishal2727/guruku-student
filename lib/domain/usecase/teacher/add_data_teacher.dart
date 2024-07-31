import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/register_teacher/add_data_teacher_response.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class AddDataTeacher {
  final TeacherRepository repository;

  AddDataTeacher(this.repository);

  Future<Either<Failure, AddDataTeacherResponse>> execute(
    String picture,
    String token,
    String name,
    String desc,
    List<String> typeTeaching,
    String price,
    String timeExperience,
    String lat,
    String lon,
    String address,
    List<String> skill,
  ) async {
    return await repository.addDataTeacher(
      picture,
      token,
      name,
      desc,
      typeTeaching,
      price,
      timeExperience,
      lat,
      lon,
      address,
      skill,
    );
  }
}
