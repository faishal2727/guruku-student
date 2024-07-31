import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/order_remote_data_source.dart';
import 'package:guruku_student/data/model/order_model/order_packages_request_model.dart';
import 'package:guruku_student/data/model/order_model/order_request_model.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order_package.dart';
import 'package:guruku_student/domain/entity/order/cancel_response.dart';
import 'package:guruku_student/domain/entity/order/order_packages_request.dart';
import 'package:guruku_student/domain/entity/order/order_request.dart';
import 'package:guruku_student/domain/entity/order/order_response.dart';
import 'package:guruku_student/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, OrderResponse>> doOrder(
    OrderRequest orderRequest,
    String token,
  ) async {
    try {
      final result = await remoteDataSource.doOrder(
        OrderRequestModel.fromEntity(orderRequest),
        token,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, OrderResponse>> doOrderPackages(
      OrderPackagesRequest orderRequest, String token) async {
    try {
      final result = await remoteDataSource.doOrderPackages(
        OrderPackagesRequestModel.fromEntity(orderRequest),
        token,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderPending(
    String token,
  ) async {
    try {
      final result = await remoteDataSource.historyOrderPending(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderSuccess(
    String token,
  ) async {
    try {
      final result = await remoteDataSource.historyOrderSuccess(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderCancel(
      String token) async {
    try {
      final result = await remoteDataSource.historyOrderCancel(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> getAllPresent(
      String token) async {
    try {
      final result = await remoteDataSource.getAllPresent(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> getAllTidakHadir(
      String token) async {
    try {
      final result = await remoteDataSource.getAllTidakHadir(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, DetailHistoryOrder>> getDetailOrder(
      String token, int id) async {
    try {
      final result = await remoteDataSource.getDetailOrder(token, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, CancelResponse>> doCancel(String code) async {
    try {
      final result = await remoteDataSource.doCancel(code);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Failed to update due to server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Trouble with connection'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrder>>> historyOrderCanceled(
      String token) async {
    try {
      final result = await remoteDataSource.historyOrderCanceled(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DataHistoryOrderPackagesUye>>>
      historyOrderPackages(String token) async {
    try {
      final result = await remoteDataSource.historyOrderPackages(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, DetailHistoryOrderPackage>> getDetailOrderPackages(
      String token, int id) async {
    try {
      final result = await remoteDataSource.getDetailOrderPackages(token, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
