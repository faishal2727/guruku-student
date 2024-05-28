import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/payment/payment_response.dart';
import 'package:guruku_student/domain/repositories/payment_repository.dart';

class Payment {
  final PaymentRepository repository;

  Payment(this.repository);

  Future<Either<Failure, PaymentResponse>> execute({
    required int orderId,
    required int total,
    required String name,
  }) async {
    return await repository.doPayment(
      orderId: orderId,
      total: total,
      name: name,
    );
  }
}
