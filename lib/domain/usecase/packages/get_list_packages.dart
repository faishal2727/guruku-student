import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/repositories/packages_repository.dart';

class GetListPackages {
  final PackagesRepository repository;

  GetListPackages(this.repository);

  Future<Either<Failure, List<Packages>>> execute(int id) async {
    return await repository.getPackages(id);
  }
}
