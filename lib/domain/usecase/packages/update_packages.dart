import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/packages_response.dart';
import 'package:guruku_student/domain/repositories/packages_repository.dart';

class UpdatePackages {
  final PackagesRepository repository;

  UpdatePackages(this.repository);

  Future<Either<Failure, PackagesResponse>> execute(
    int id,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
  ) async {
    return await repository.updatePackages(
      id,
      duration,
      name,
      price,
      desc,
      day,
      time,
    );
  }
}
