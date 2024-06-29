import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/repositories/wishlist_repository.dart';

class AddWishlist {
  final WishlistRepository repository;

  AddWishlist(this.repository);

  Future<Either<Failure, String>> execute(
      {required String token,
      required int idTeacher,
      }) async {
    return repository.addWishlist(token, idTeacher);
  }
}
