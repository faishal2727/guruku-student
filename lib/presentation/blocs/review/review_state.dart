part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final List<Review>? review;
  final RequestStateReview state;
  final String message;

  const ReviewState({
    this.review,
    required this.state,
    required this.message,
  });

  @override
  List<Object?> get props => [
        review,
        state,
        message,
      ];

  ReviewState copyWith({
    List<Review>? review,
    RequestStateReview? state,
    String? message,
  }) {
    return ReviewState(
      review: review ?? this.review,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  factory ReviewState.initial() {
    return const ReviewState(
      review: null,
      state: RequestStateReview.empty,
      message: '',
    );
  }
}

