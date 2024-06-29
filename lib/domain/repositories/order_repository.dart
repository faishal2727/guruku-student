import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/order/order_request.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderResponse>> doOrder(
      OrderRequest orderRequest, String token);
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderPending(
      String token);
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderSuccess(
      String token);
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderCancel(
      String token);
  Future<Either<Failure, List<DataHistoryOrder>>> getAllPresent(String token);
  Future<Either<Failure, DetailHistoryOrder>> getDetailOrder(
    String token,
    int id,
  );
}
