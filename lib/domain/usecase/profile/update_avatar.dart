import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/repositories/profile_repository.dart';

class UpdateAvatar {
  final ProfileRepository repository;

  UpdateAvatar(this.repository);

  Future<Either<Failure, UpdateProfileResponse>> execute(List<int> bytes,
      String fileName, String token) async {
    return await repository.updateAvatar(bytes,fileName, token);
  }
}
