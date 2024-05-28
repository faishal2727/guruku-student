import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/domain/repositories/profile_repository.dart';

class DetailProfile {
  final ProfileRepository repository;

  DetailProfile(this.repository);

  Future<Either<Failure, DetailProfileResponse>> execute(String token) async {
    return await repository.getDetailProfile(token);
  }
}