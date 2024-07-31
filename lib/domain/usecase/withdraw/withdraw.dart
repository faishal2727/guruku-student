import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_response.dart';
import 'package:guruku_student/domain/repositories/withdraw_repository.dart';

class Withdraw {
  final WithdrawRepository repository;
  Withdraw(this.repository);
  Future<Either<Failure, WithdrawResponse>> execute(
    String token,
    int idTeacher,
    String amount,
    String noBank,
    String bankName,
  ) async {
    return repository.reqWd(token, idTeacher, amount, noBank, bankName);
  }
}
