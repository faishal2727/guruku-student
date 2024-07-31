import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/order_teacher_remote_data_source.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/repositories/order_teacher_repository.dart';

class OrderTeacherRepositoryImpl implements OrderTeacherRepository {
  final OrderTeacherRemoteDataSource dataSource;

  OrderTeacherRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> getAllPresentTeacher(
      String token) async {
    try {
      final result = await dataSource.orderPresentTeacher(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderCancelTeacher(
      String token) async {
    try {
      final result = await dataSource.orderCancelTeacher(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderPendingTeacher(
      String token) async {
    try {
      final result = await dataSource.orderPendingTeacher(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderSuccessTeacher(
      String token) async {
    try {
      final result = await dataSource.orderSuccessTeacher(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, DetailHistoryOrder>> getDetailOrderTeacher(
    String token,
    int idTeacher,
    int idOrder,
  ) async {
    try {
      final result = await dataSource.getDetailOrder(token, idTeacher, idOrder);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updatePresent(
      String token, int id) async {
    try {
      final result = await dataSource.updatePresent(token, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateTidakHadir(
      String token, int id) async {
    try {
      final result = await dataSource.updateTidak(token, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrderPackagesUye>>>
      historyOrderPackagesTeacher(String token) async {
    try {
      final result = await dataSource.historyOrderPackagesTeacher(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updatePresentPackage(
    String token,
    int packageId,
    int orderId,
    String status,
  ) async {
    try {
      final result = await dataSource.updatePresentPackages(
        token,
        packageId,
        orderId,
        status,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }
}
