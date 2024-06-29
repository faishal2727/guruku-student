import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/repositories/wishlist_repository.dart';

class GetDetailWishlist {
  final WishlistRepository repository;

  GetDetailWishlist(this.repository);

  Future<Either<Failure, bool>> execute({
    required String token,
    required int idTeacher,
  }) async {
    return repository.getDetailWishlist(
      token,
      idTeacher,
    );
  }
}
