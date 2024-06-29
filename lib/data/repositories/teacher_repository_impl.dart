// ignore_for_file: use_rethrow_when_possible

import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/local/teacher_local_data_source.dart';
import 'package:guruku_student/data/datasources/remote/register_teacher_remote_data_source.dart';
import 'package:guruku_student/data/datasources/remote/teacher_remote_data_source.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_table.dart';
import 'package:guruku_student/domain/entity/register_teacher/add_data_teacher_response.dart';
import 'package:guruku_student/domain/entity/register_teacher/register_teacher_response.dart';
import 'package:guruku_student/domain/entity/teacher/bookmark_teacher_respone.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/domain/repositories/teacher_repository.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  final TeacherRemoteDataSource remoteDataSource;
  final RegisterTeacherRemoteDataSource teacherRemoteDataSource;
  final TeacherLocalDataSource localDataSource;

  TeacherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.teacherRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Teacher>>> getAllTeacher() async {
    try {
      final result = await remoteDataSource.getAllTeacher();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TeacherDetail>> getTeacherDetail(int id) async {
    try {
      final result = await remoteDataSource.getTeacherDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Teacher>>> getTeacherMath() async {
    try {
      final result = await remoteDataSource.getTeacherMath();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Teacher>>> getTeacherBilogy() async {
    try {
      final result = await remoteDataSource.getTeacherBilogy();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Teacher>>> getTeacherEnglish() async {
    try {
      final result = await remoteDataSource.getTeacherEnglish();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Teacher>>> getTeacherIndonesian() async {
    try {
      final result = await remoteDataSource.getTeacherIndonesian();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Teacher>>> getSearchTeacher(String query) async {
    try {
      final result = await remoteDataSource.getSearchTeacher(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the networl'));
    }
  }

  @override
  Future<Either<Failure, BookmarkTeacherResponse>> addTeacherToBookmark(
    int idStudent,
    int idTeacher,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.addBookmarkTeacher(
        idStudent: idStudent,
        idTeacher: idTeacher,
        token: token,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, String>> saveBookmarkTeacher(
      TeacherDetail teacher) async {
    try {
      final result = await localDataSource.insertBookmark(
        TeacherTable.fromEntity(teacher),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeBookmarkTeacher(
      TeacherDetail teacher) async {
    try {
      final result = await localDataSource.removeBookmark(
        TeacherTable.fromEntity(teacher),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> issAddedToBookmark(int id) async {
    final result = await localDataSource.getBookmarkById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<Teacher>>> getBookmarkList() async {
    final result = await localDataSource.getBookmarkList();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, RegisterTeacherResponse>> register(
    String token,
    String username,
    String email,
    String phone,
    String education,
    String jurusan,
    String tahunLulus,
    String idCard,
    String file,
  ) async {
    try {
      final result = await remoteDataSource.registerTeacher(
        token,
        username,
        email,
        phone,
        education,
        jurusan,
        tahunLulus,
        idCard,
        file,
      );
      return Right(result.toEntity());
    } on AuthException {
      return const Left(AuthFailure('Input dengan benar'));
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, AddDataTeacherResponse>> addDataTeacher(
    String picture,
    String token,
    String name,
    String desc,
    String typeTeaching,
    String price,
    String timeExperience,
    String lat,
    String lon,
    String address,
  ) async {
    try {
      final result = await teacherRemoteDataSource.addDataTeacher(
        picture,
        token,
        name,
        desc,
        typeTeaching,
        price,
        timeExperience,
        lat,
        lon,
        address,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to uodate due to server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Trouble with connection'));
    }
  }

  @override
  Future<Either<Failure, AddDataTeacherResponse>> pickSchedule(
    String token,
    List<Map<String, dynamic>> schedule,
  ) async {
    try {
      final result =
          await teacherRemoteDataSource.pickSchedule(token, schedule);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to update due to server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Trouble with connection'));
    }
  }
}
