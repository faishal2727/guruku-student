import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/notif/notif_response.dart';

abstract class NotifRepository {
  Future<Either<Failure, List<NotifResponse>>> getNotifStudent(String token);
}