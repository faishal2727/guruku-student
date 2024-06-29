import 'package:dartz/dartz.dart';
import 'package:guruku_student/common/failure.dart';
import 'package:guruku_student/domain/entity/wishlist/wishlist.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<Wishlist>>> getAllWhislist(String token);
  Future<Either<Failure, String>> addWishlist(
    String token,
    int idTeacher,
  
  );
  Future<Either<Failure, bool>> getDetailWishlist(
    String token,
    int idTeacher,
  );
  Future<Either<Failure, String>> removeWishlist(
    String token,
    int idTeacher,
  );
}
