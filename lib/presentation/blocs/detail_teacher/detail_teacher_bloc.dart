import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/teacher/teacher_detail.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/teacher/get_teacher_detail.dart';
import 'package:guruku_student/domain/usecase/wishlist.dart/add_wishlist.dart';
import 'package:guruku_student/domain/usecase/wishlist.dart/get_detail_wishlist.dart';
import 'package:guruku_student/domain/usecase/wishlist.dart/remove_wishlist.dart';

part 'detail_teacher_event.dart';
part 'detail_teacher_state.dart';

class DetailTeacherBloc extends Bloc<DetailTeacherEvent, DetailTeacherState> {
  static const wishlistAddSuccessMessage = 'Ditambahkan ke wishlist';
  static const wishlistRemoveSuccessMessage = 'Dihapus dari wishlist';

  final GetTeaacherDetail getTeaacherDetail;
  final GetAuth getAuth;
  final AddWishlist addWishlist;
  final GetDetailWishlist getDetailWishlist;
  final RemoveWishlist removeWishlist;

  DetailTeacherBloc({
    required this.getTeaacherDetail,
    required this.getAuth,
    required this.addWishlist,
    required this.getDetailWishlist,
    required this.removeWishlist,
  }) : super(DetailTeacherState.initial()) {
    on<OnDetailTeacherEvent>(
      (event, emit) async {
        emit(state.copyWith(state: RequestStateDetail.loading));

        final result = await getTeaacherDetail.execute(event.id);

        result.fold(
          (failure) {
            emit(state.copyWith(
                state: RequestStateDetail.error, message: failure.message));
          },
          (data) {
            emit(state.copyWith(
                state: RequestStateDetail.loaded, teacher: data));
          },
        );
      },
    );

    on<AddWishlistEvent>(
      (event, emit) async {
        emit(state.copyWith(wishlistMessage: ''));

        final auth = await getAuth.execute();

        if (auth != null) {
          final String token = auth.token;
          final teacherId = event.idTeacher;

          final result = await addWishlist.execute(
            token: token,
            idTeacher: teacherId,
          );

          result.fold(
            (failure) {
              emit(state.copyWith(wishlistMessage: failure.message));
            },
            (messageSuccess) {
              emit(state.copyWith(
                wishlistMessage: wishlistAddSuccessMessage,
                isAddedToWishlist: true, // Update state here
              ));
              add(LoadWishlistStatusEvent(teacherId));
            },
          );
        }
      },
    );

    on<RemoveWishlistEvent>(
      (event, emit) async {
        emit(state.copyWith(wishlistMessage: ''));

        final auth = await getAuth.execute();

        if (auth != null) {
          final String token = auth.token;
          final teacherId = event.id;

          final result = await removeWishlist.execute(
            token: token,
            idTeacher: teacherId,
          );

          result.fold(
            (failure) {
              emit(state.copyWith(wishlistMessage: failure.message));
            },
            (messageSuccess) {
              emit(state.copyWith(
                wishlistMessage: wishlistRemoveSuccessMessage,
                isAddedToWishlist: false, // Update state here
              ));
              add(LoadWishlistStatusEvent(event.id));
            },
          );
        }
      },
    );

    on<LoadWishlistStatusEvent>(
      (event, emit) async {
        final auth = await getAuth.execute();

        if (auth != null) {
          final int teacherId = event.id;
          final String token = auth.token;

          final result = await getDetailWishlist.execute(
            token: token,
            idTeacher: teacherId,
          );

          result.fold(
            (failure) {
              emit(state.copyWith(wishlistMessage: failure.message));
            },
            (isWishlist) {
              emit(state.copyWith(isAddedToWishlist: isWishlist));
            },
          );
        }
      },
    );
  }
}

// class DetailTeacherBloc extends Bloc<DetailTeacherEvent, DetailTeacherState> {
//   final GetTeaacherDetail getTeaacherDetail;

//   DetailTeacherBloc(this.getTeaacherDetail) : super(DetailTeacherEmpty()) {
//     on<OnDetailTeacherEvent>(_onDetailTeacherEvent);
//   }

//   Future<void> _onDetailTeacherEvent(
//       OnDetailTeacherEvent event, Emitter<DetailTeacherState> emit) async {
//     emit(DetailTeacherLoading());
//     final id = event.id;
//     debugPrint("YUK $id");

//     final result = await getTeaacherDetail.execute(id);
//     debugPrint("YUK2 $result");

//     result.fold(
//       (failure) {
//         emit(DetailTeacherError(failure.message));
//       },
//       (detail) {
//          debugPrint("UDIN: $detail");
//         emit(DetailTeacherHasData(detail));
//         debugPrint("Schedule: ${detail.schedule}");
//       },
//     );
//   }
// }
