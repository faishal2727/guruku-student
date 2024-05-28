import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/payment/payment_response.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentResponse>> doPayment({
    required int orderId,
    required int total,
    required String name,
  });
}
