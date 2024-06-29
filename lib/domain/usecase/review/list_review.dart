import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/review/review.dart';
import 'package:guruku_student/domain/repositories/review_repository.dart';

class ListReview {
  final ReviewRepository repository;

  ListReview(this.repository);

  Future<Either<Failure, List<Review>>> execute(
      {required int id}) {
    return repository.getReview(id);
  }
}
