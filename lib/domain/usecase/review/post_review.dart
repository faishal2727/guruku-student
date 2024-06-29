import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/review/post_review_response.dart';
import 'package:guruku_student/domain/entity/review/review_request.dart';
import 'package:guruku_student/domain/repositories/review_repository.dart';

class PostReview {
  final ReviewRepository repository;

  PostReview(this.repository);

  Future<Either<Failure, PostReviewResponse>> execute({
    required String token,
    required ReviewRequest request,
  }) async {
    return repository.postReview(token, request);
  }
}
