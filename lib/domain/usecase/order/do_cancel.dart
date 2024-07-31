import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/order/cancel_response.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class DoCancel {
  final OrderRepository repository;

  DoCancel(this.repository);

  Future<Either<Failure, CancelResponse>> execute({
    required String code,
  }) async {
    return await repository.doCancel(code);
  }
}