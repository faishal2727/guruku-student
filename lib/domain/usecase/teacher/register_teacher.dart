import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/register_teacher/register_teacher_response.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class RegisterTeacher {
  final TeacherRepository repository;

  RegisterTeacher(this.repository);

  Future<Either<Failure, RegisterTeacherResponse>> execute(
    String token,
    String username,
    String email,
    String phone,
    String education,
    String jurusan,
    String tahunLulus,
    String idCard,
    String file,
  ) async {
    return await repository.register(
      token,
      username,
      email,
      phone,
      education,
      jurusan,
      tahunLulus,
      idCard,
      file,
    );
  }
}
