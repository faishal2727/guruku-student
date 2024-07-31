import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_response.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, WithdrawResponse>> reqWd(
    String token,
    int idTeacher,
    String amount,
    String noBank,
    String bankName,
  );
  Future<Either<Failure, List<WithdrawDetailResponse>>> listWdTeacher(
    String token,
    int id,
  );
  Future<Either<Failure, List<WithdrawDetailResponse>>> listWdStudent(
    String token,
  );
  Future<Either<Failure, WithdrawDetailResponse>> getDetailWd(
    String token,
    int id,
  );
}
