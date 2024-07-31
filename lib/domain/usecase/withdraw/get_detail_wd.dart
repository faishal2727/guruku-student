import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
import 'package:guruku_student/domain/repositories/withdraw_repository.dart';

class GetDetailWd {
  final WithdrawRepository repository;

  GetDetailWd(this.repository);

  Future<Either<Failure, WithdrawDetailResponse>> execute(
      String token, int id) async {
    return repository.getDetailWd(
      token,
      id,
    );
  }
}
