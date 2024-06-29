import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/review/post_review_response.dart';
import 'package:guruku_student/domain/entity/review/review.dart';
import 'package:guruku_student/domain/entity/review/review_request.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<Review>>> getReview(int id);
  Future<Either<Failure, PostReviewResponse>> postReview(
    String token,
    ReviewRequest request,
  );
}
