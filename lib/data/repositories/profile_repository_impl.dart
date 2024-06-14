import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/profile_remote_data_source.dart';
import 'package:guruku_student/data/model/profile_model/update_profile_request_model..dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_request.dart';
import 'package:guruku_student/domain/entity/profile/update_profile_response.dart';
import 'package:guruku_student/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DetailProfileResponse>> getDetailProfile(
      String token) async {
    try {
      final result = await remoteDataSource.getDetailProfile(token);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UpdateProfileResponse>> updateProfile(
      UpdateProfileRequest updateProfile, String token) async {
    try {
      final result = await remoteDataSource.updateProfile(
        UpdateProfileRequestModel.fromEntity(updateProfile),
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
  Future<Either<Failure, UpdateProfileResponse>> updateAvatar(
      List<int> bytes, String fileName, String token) async {
    try {
      final result =
          await remoteDataSource.updateAvatar(bytes, fileName, token);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('Failed to update avatar due to server error'));
    } on SocketException {
      return const Left(ConnectionFailure('Trouble with connection'));
    }
  }
}
