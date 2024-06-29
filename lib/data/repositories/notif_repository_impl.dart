import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/notif_remote_data_source.dart';
import 'package:guruku_student/domain/entity/notif/notif_response.dart';
import 'package:guruku_student/domain/repositories/notif_repository.dart';

class NotifRepositoryImpl implements NotifRepository {
  final NotifRemoteDataSource dataSource;

  NotifRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<NotifResponse>>> getNotifStudent(String token) async {
      try {
      final result = await dataSource.getNotifStudent(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
  
}