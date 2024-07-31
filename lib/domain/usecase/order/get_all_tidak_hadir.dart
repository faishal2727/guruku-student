import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class GetAllTidakHadir {
  final OrderRepository repository;

  GetAllTidakHadir(this.repository);

  Future<Either<Failure, List<DataHistoryOrder>>> execute(
      {required String token}) async {
    return repository.getAllTidakHadir(token);
  }
}