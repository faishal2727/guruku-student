import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/repositories/order_teacher_repository.dart';

class UpdatePresent {
  final OrderTeacherRepository repository;

  UpdatePresent(this.repository);

  Future<Either<Failure, UpdateProfileResponse>> execute(
      String token, int id) async {
    return repository.updatePresent(token, id);
  }
}

class UpdateTidakHadir {
  final OrderTeacherRepository repository;

  UpdateTidakHadir(this.repository);

  Future<Either<Failure, UpdateProfileResponse>> execute(
      String token, int id) async {
    return repository.updateTidakHadir(token, id);
  }
}

class UpdatePresentPackages {
  final OrderTeacherRepository repository;

  UpdatePresentPackages(this.repository);

  Future<Either<Failure, UpdateProfileResponse>> execute(
    String token,
    int packageId,
    int orderId,
    String status,
  ) async {
    return repository.updatePresentPackage(
      token,
      packageId,
      orderId,
      status,
    );
  }
}
