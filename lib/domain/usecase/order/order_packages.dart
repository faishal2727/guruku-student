import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/order/order_packages_request.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class OrderPackages {
  final OrderRepository repository;

  OrderPackages(this.repository);

  Future<Either<Failure, OrderResponse>> execute({
    required OrderPackagesRequest orderRequest,
    required String token,
  }) async {
    return await repository.doOrderPackages(orderRequest, token);
  }
}
