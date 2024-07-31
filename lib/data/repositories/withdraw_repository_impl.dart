import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/withdraw_remote_data_source.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_response.dart';
import 'package:guruku_student/domain/repositories/withdraw_repository.dart';

class WithdrawRepositoryImpl implements WithdrawRepository {
  final WithdrawRemoteDataSource dataSource;

  WithdrawRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, WithdrawResponse>> reqWd(
    String token,
    int idTeacher,
    String amount,
    String noBank,
    String bankName,
  ) async {
    try {
      final result = await dataSource.reqWd(
        token,
        idTeacher,
        amount,
        noBank,
        bankName,
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, List<WithdrawDetailResponse>>> listWdTeacher(
    String token,
    int id,
  ) async {
    try {
      final result = await dataSource.listWdTeacher(token, id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<WithdrawDetailResponse>>> listWdStudent(
      String token) async {
    try {
      final result = await dataSource.listWdStudent(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, WithdrawDetailResponse>> getDetailWd(
      String token, int id) async {
    try {
      final result = await dataSource.getDetailWd(token, id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
