import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';
import 'package:guruku_student/domain/repositories/order_teacher_repository.dart';

class OrderPendingTeacher {
  final OrderTeacherRepository repository;

  OrderPendingTeacher(this.repository);

  Future<Either<Failure, List<DataHistoryOrder>>> execute(
      {required String token}) async {
    return repository.historyOrderPendingTeacher(token);
  }
}

class OrderPackageTeacher {
  final OrderTeacherRepository repository;

  OrderPackageTeacher(this.repository);

  Future<Either<Failure, List<DataHistoryOrderPackagesUye>>> execute(
      {required String token}) async {
    return repository.historyOrderPackagesTeacher(token);
  }
}
