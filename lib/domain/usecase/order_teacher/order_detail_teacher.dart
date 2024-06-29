import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/repositories/order_teacher_repository.dart';

class OrderDetailTeacher {
  final OrderTeacherRepository repository;

  OrderDetailTeacher(this.repository);

  Future<Either<Failure, DetailHistoryOrder>> execute(
      {required String token,
      required int idTeacher,
      required int idOrder}) async {
    return repository.getDetailOrderTeacher(token, idTeacher, idOrder);
  }
}
