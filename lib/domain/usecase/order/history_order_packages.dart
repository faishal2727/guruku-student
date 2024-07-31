import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class HistoryOrderPackages {
  final OrderRepository repository;

  HistoryOrderPackages(this.repository);

  Future<Either<Failure, List<DataHistoryOrderPackagesUye>>> execute(
      {required String token}) async {
    return repository.historyOrderPackages(token);
  }
}
