import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/domain/entity/wishlist/wishlist.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/wishlist.dart/get_all_wishlist.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetAuth getAuth;
  final GetAllWishlist getAllWishlist;

  WishlistBloc({
    required this.getAuth,
    required this.getAllWishlist,
  }) : super(WishlistInitial()) {
    on<GetAllWishlistEvent>(
      (event, emit) async {
        emit(WishlistLoading());

        final user = await getAuth.execute();

        if (user != null) {
          final String token = user.token;

          final result = await getAllWishlist.execute(token: token);

          result.fold(
            (failure) {
              emit(WishlistError(failure.message));
            },
            (data) {
              if (data.isEmpty) {
                emit(WishlistEmpty());
              } else {
                emit(WishlistLoaded(data));
              }
            },
          );
        }
      },
    );
  }
}
