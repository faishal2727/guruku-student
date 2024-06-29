import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/repositories/wishlist_repository.dart';

class RemoveWishlist {
  final WishlistRepository repository;

  RemoveWishlist(this.repository);

  Future<Either<Failure, String>> execute({
    required String token,
    required int idTeacher,
  }) async {
    return repository.removeWishlist(token, idTeacher);
  }
}
