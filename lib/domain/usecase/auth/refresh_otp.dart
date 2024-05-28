import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/auth/refresh_otp.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class RefreshOtp {
  final AuthRepository repository;
  RefreshOtp(this.repository);

  Future<Either<Failure, RefreshOtpResponse>> execute({
    required String email,
  }) async {
    return repository.refreshOtp(email: email);
  }
}
