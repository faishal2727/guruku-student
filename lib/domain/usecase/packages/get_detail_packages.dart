import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/repositories/packages_repository.dart';

class GetDetailPackages {
  final PackagesRepository repository;

  GetDetailPackages(this.repository);

  Future<Either<Failure, Packages>> execute(int id) async {
    return await repository.getDetailPackages(id);
  }
}