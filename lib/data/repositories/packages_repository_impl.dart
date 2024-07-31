import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/packages_remote_data_source.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/entity/teacher/packages_response.dart';
import 'package:guruku_student/domain/repositories/packages_repository.dart';

class PackagesRepositoryImpl implements PackagesRepository {
  final PackagesRemoteDataSource dataSource;
  PackagesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Packages>>> getPackages(int id) async {
    try {
      final result = await dataSource.getPackages(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, Packages>> getDetailPackages(int id) async {
    try {
      final result = await dataSource.getDetailPackages(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PackagesResponse>> addPackages(
    String token,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
    int teacherId,
  ) async {
    try {
      final result = await dataSource.addPackages(
        token,
        duration,
        name,
        price,
        desc,
        day,
        time,
        teacherId,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to post due to server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Trouble with connection'));
    }
  }

  @override
  Future<Either<Failure, List<Packages>>> getMyPackages(String token) async {
    try {
      final result = await dataSource.getMyPackages(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PackagesResponse>> updatePackages(
    int id,
    int duration,
    String name,
    int price,
    String desc,
    List<String> day,
    List<String> time,
  ) async {
    try {
      final result = await dataSource.updatePackages(
        id,
        duration,
        name,
        price,
        desc,
        day,
        time,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to post due to server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Trouble with connection'));
    }
  }
}
