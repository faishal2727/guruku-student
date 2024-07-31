import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/entity/teacher/packages_response.dart';

abstract class PackagesRepository {
  Future<Either<Failure, List<Packages>>> getPackages(int id);
  Future<Either<Failure, Packages>> getDetailPackages(int id);
  Future<Either<Failure, PackagesResponse>> addPackages(
    String token,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
    int teacherId,
  );
  Future<Either<Failure, List<Packages>>> getMyPackages(String token);
  Future<Either<Failure, PackagesResponse>> updatePackages(
    int id,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
  );
}
