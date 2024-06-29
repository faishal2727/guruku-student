import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/wishlist/wishlist.dart';
import 'package:guruku_student/domain/repositories/wishlist_repository.dart';

class GetAllWishlist {
  final WishlistRepository repository;

  GetAllWishlist(this.repository);

  Future<Either<Failure, List<Wishlist>>> execute({
    required String token,
  }) async {
    return repository.getAllWhislist(token);
  }
}
