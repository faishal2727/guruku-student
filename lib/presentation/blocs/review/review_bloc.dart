import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/domain/entity/review/review.dart';
import 'package:guruku_student/domain/entity/review/review_request.dart';
import 'package:guruku_student/domain/usecase/auth/get_auth.dart';
import 'package:guruku_student/domain/usecase/review/list_review.dart';
import 'package:guruku_student/domain/usecase/review/post_review.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ListReview listReview;
  final GetAuth getAuth;
  final PostReview postReview;

  ReviewBloc({
    required this.listReview,
    required this.getAuth,
    required this.postReview,
  }) : super(ReviewState.initial()) {
    on<GetListReviewEvent>(
      (event, emit) async {
        emit(state.copyWith(state: RequestStateReview.loading));

        final result = await listReview.execute(id: event.teacherId);
        debugPrint("nguntul $result");
        result.fold(
          (failure) {
            emit(state.copyWith(
              state: RequestStateReview.error,
              message: failure.message,
            ));
          },
          (data) {
            if (data.isEmpty) {
              emit(state.copyWith(state: RequestStateReview.empty));
            } else {
              debugPrint("nguntul $data");
              emit(state.copyWith(
                state: RequestStateReview.loaded,
                review: data,
              ));
            }
          },
        );
      },
    );

    on<PostReviewEvent>(
      (event, emit) async {
        emit(state.copyWith(state: RequestStateReview.loading));
        final user = await getAuth.execute();

        if (user != null) {
          final request = ReviewRequest(
            idTeacher: event.idTeacher,
            idOrder: event.idOrder,
            rate: event.rate,
            desc: event.desc,
            detail: event.detail,
          );
          final result = await postReview.execute(
            token: user.token,
            request: request,
          );
          debugPrint("Result from postReview.execute(): $result");
          result.fold(
            (failure) {
              emit(
                state.copyWith(
                  state: RequestStateReview.error,
                  message: failure.message,
                ),
              );
            },
            (data) {
              emit(
                state.copyWith(
                  state: RequestStateReview.loaded,
                ),
              );
            },
          );
        }
      },
    );
  }
}
