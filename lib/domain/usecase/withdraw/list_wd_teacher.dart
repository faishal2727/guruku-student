import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
import 'package:guruku_student/domain/repositories/withdraw_repository.dart';

class ListWdTeacher {
  final WithdrawRepository repository;

  ListWdTeacher(this.repository);

  Future<Either<Failure, List<WithdrawDetailResponse>>> execute(
    String token,
    int idTeacher,
  ) async {
    return repository.listWdTeacher(
      token,
      idTeacher,
    );
  }
}
