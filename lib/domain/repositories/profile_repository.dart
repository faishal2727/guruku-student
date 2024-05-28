import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_request.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';

abstract class ProfileRepository {
  Future<Either<Failure, DetailProfileResponse>> getDetailProfile(String token);
  Future<Either<Failure, UpdateProfileResponse>> updateProfile(UpdateProfileRequest updateProfile, String token);
  Future<Either<Failure, UpdateProfileResponse>> updateAvatar(List<int> bytes, String fileName, String token);
}
