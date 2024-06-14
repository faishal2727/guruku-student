import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/order/order_request.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class Order {
  final OrderRepository repository;

  Order(this.repository);

  Future<Either<Failure, OrderResponse>> execute({
    required OrderRequest orderRequest,
    required String token,
  }) async {
    return await repository.doOrder(orderRequest, token);
  }
}