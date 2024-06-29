import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/register_teacher_remote_data_source.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_data_teacher_response.dart';
import 'package:guruku_student/domain/repositories/my_data_teacher_repository.dart';

class MyDataTeacherRepositoryImpl implements MyDataTeacherRepository {
  final RegisterTeacherRemoteDataSource teacherRemoteDataSource;

  MyDataTeacherRepositoryImpl({required this.teacherRemoteDataSource});

  @override
  Future<Either<Failure, MyDataTeacherResponse>> getMyDataTeacher(
      String token, int id) async {
    try {
      final result = await teacherRemoteDataSource.getMyDataTeacher(token, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
