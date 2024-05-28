import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/auth/login_response.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<Either<Failure, LoginResponse>> execute({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}