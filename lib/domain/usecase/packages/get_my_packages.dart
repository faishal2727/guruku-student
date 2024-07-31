import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/repositories/packages_repository.dart';

class GetMyPackages {
  final PackagesRepository repository;

  GetMyPackages(this.repository);

  Future<Either<Failure, List<Packages>>> execute(String token) async {
    return await repository.getMyPackages(token);
  }
}
