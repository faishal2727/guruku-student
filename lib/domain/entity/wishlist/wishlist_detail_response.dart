import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/wishlist/data_detail_wishlist.dart';

class WishlistDetailResponse extends Equatable {
  final int code;
  final String status;
  final bool error;
  final String message;
  final DataDetailWishlist data;
  
  const WishlistDetailResponse({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [
        code,
        error,
        message,
        data,
      ];
}
