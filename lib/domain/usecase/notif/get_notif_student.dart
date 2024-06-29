import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/notif/notif_response.dart';
import 'package:guruku_student/domain/repositories/notif_repository.dart';

class GetNotifStudent {
  final NotifRepository repository;

  GetNotifStudent(this.repository);

  Future<Either<Failure,List<NotifResponse>>> execute(String token) async {
    return repository.getNotifStudent(token);
  }
}