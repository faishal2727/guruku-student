import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/repositories/withdraw_repository.dart';

import '../../entity/withdraw/withdraw_detail_response.dart';

class ListWdStudent {
  final WithdrawRepository repository;

  ListWdStudent(this.repository);

  Future<Either<Failure, List<WithdrawDetailResponse>>> execute(
    String token,
  ) async {
    return repository.listWdStudent(
      token,
    );
  }
}
