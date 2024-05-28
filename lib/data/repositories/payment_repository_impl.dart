import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/payment_remote_data_sorce.dart';
import 'package:guruku_student/domain/entity/payment/payment_response.dart';
import 'package:guruku_student/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaymentResponse>> doPayment(
      {required int orderId, required int total, required String name}) async {
    try {
      final result = await remoteDataSource.doPayment(
          orderId: orderId, total: total, name: name);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
