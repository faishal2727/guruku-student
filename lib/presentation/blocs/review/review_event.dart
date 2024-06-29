part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

final class GetListReviewEvent extends ReviewEvent {
  final int teacherId;

  const GetListReviewEvent(this.teacherId);

  @override
  List<Object> get props => [];
}

final class PostReviewEvent extends ReviewEvent {
  final int idTeacher;
  final int idOrder;
  final String rate;
  final String desc;
  final String detail;

  const PostReviewEvent({
    required this.idTeacher,
    required this.idOrder,
    required this.rate,
    required this.desc,
    required this.detail,
  });

  @override
  List<Object> get props => [
        idTeacher,
        rate,
        desc,
        detail,
      ];
}
