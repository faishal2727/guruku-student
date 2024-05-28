import 'package:guruku_student/domain/entity/auth/login_response.dart';
import 'package:guruku_student/domain/repositories/auth_repository.dart';

class SaveAuth {
  final AuthRepository repository;

  SaveAuth(this.repository);

  Future<String> execute(LoginResponse data) async {
    return await repository.saveAuth(data);
  }
}