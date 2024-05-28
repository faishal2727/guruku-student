import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/auth/req_forgot_pw_response.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class ReqForgotPassword {
  final AuthRepository repository;
  ReqForgotPassword(this.repository);

  Future<Either<Failure, ReqForgotPwResponse>> execute({
    required String email,
  }) async {
    return repository.reqForgotPw(email: email);
  }
}
