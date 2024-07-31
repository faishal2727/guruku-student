import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order_package.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class GetDetailOrder {
  final OrderRepository repository;

  GetDetailOrder(this.repository);

  Future<Either<Failure, DetailHistoryOrder>> execute({required String token, required int id}) async {
    return repository.getDetailOrder(token, id);
  }
}

class GetDetailOrderPackages{
  final OrderRepository repository;

  GetDetailOrderPackages(this.repository);

  Future<Either<Failure, DetailHistoryOrderPackage>> execute({required String token, required int id}) async {
    return repository.getDetailOrderPackages(token, id);
  }
}