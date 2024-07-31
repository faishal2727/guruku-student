import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';

abstract class OrderTeacherRepository {
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderPendingTeacher(
      String token);
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderSuccessTeacher(
      String token);
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderCancelTeacher(
      String token);
  Future<Either<Failure, List<DataHistoryOrder>>> getAllPresentTeacher(
      String token);
  Future<Either<Failure, DetailHistoryOrder>> getDetailOrderTeacher(
    String token,
    int idTeacher,
    int idOrder,
  );
  Future<Either<Failure, UpdateProfileResponse>> updatePresent(
    String token,
    int id,
  );
  Future<Either<Failure, UpdateProfileResponse>> updatePresentPackage(
    String token,
    int packageId,
    int orderId,
    String status,
  );
  Future<Either<Failure, UpdateProfileResponse>> updateTidakHadir(
    String token,
    int id,
  );
  Future<Either<Failure, List<DataHistoryOrderPackagesUye>>>
      historyOrderPackagesTeacher(
    String token,
  );
}
