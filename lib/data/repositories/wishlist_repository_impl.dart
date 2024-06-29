import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/wishlist_remote_data_source.dart';
import 'package:guruku_student/domain/entity/wishlist/wishlist.dart';
import 'package:guruku_student/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<Wishlist>>> getAllWhislist(String token) async {
    try {
      final result = await remoteDataSource.getAllWishlist(token);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> addWishlist(
    String token,
    int idTeacher,
   
  ) async {
    try {
      final result = await remoteDataSource.addWishlist(
        token,
        idTeacher,
      // AddWishlistRequestModel.fromEntity(req),  
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }

  @override
  Future<Either<Failure, bool>> getDetailWishlist(
    String token,
    int idTeacher,
  ) async {
    try {
      final result = await remoteDataSource.getWishlistDetail(
        token,
        idTeacher,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, String>> removeWishlist(
      String token, int idTeacher) async {
    try {
      final result = await remoteDataSource.removeWishlist(token, idTeacher);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Gagal koneksi internet'));
    }
  }
}
