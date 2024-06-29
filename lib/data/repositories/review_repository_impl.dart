import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/exception.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/data/datasources/remote/review_remote_data_source.dart';
import 'package:guruku_student/data/model/review/review_request_model.dart';
import 'package:guruku_student/domain/entity/review/post_review_response.dart';
import 'package:guruku_student/domain/entity/review/review.dart';
import 'package:guruku_student/domain/entity/review/review_request.dart';
import 'package:guruku_student/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource dataSource;

  ReviewRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Review>>> getReview(int id) async {
    try {
      final result = await dataSource.getReview(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PostReviewResponse>> postReview(
    String token,
    ReviewRequest request,
  ) async {
    try {
      final result = await dataSource.postReview(
        token,
        ReviewRequestModel.fromEntity(request),
      );
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('message'));
    } on SocketException {
      return const Left(ConnectionFailure('Troble connection'));
    }
  }
}
