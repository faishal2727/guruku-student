import 'package:guruku_student/domain/entity/auth/login_response.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class GetAuth {
  final AuthRepository repository;

  GetAuth(this.repository);

  Future<LoginResponse?> execute() async {
    return await repository.getAuth();
  }
}