import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/packages_response.dart';
import 'package:guruku_student/domain/repositories/packages_repository.dart';

class AddPackages {
  final PackagesRepository repository;

  AddPackages(this.repository);

  Future<Either<Failure, PackagesResponse>> execute(
    String token,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
    int teacherId,
  ) async {
    return await repository.addPackages(
      token,
      duration,
      name,
      price,
      desc,
      day,
      time,
      teacherId,
    );
  }
}
