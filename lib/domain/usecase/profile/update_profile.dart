import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_request.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/repositories/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;
  UpdateProfile(this.repository);

  Future<Either<Failure, UpdateProfileResponse>> execute({
    required UpdateProfileRequest updateProfile,
    required String token,
  }) async {
    return await repository.updateProfile(
      updateProfile,
      token,
    );
  }
}
