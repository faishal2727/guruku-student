import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/auth/forgot_pw_response.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class ForgotPassword {
  final AuthRepository repository;
  ForgotPassword(this.repository);

  Future<Either<Failure, ForgotPwResponse>> execute({
    required String email,
    required String password,
  }) async {
    return await repository.forgotPw(
      email: email,
      password: password,
    );
  }
}
