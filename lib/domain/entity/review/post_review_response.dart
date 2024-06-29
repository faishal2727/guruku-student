import 'package:equatable/equatable.dart';

class PostReviewResponse extends Equatable {
  final int code;
  final bool error;
  final String message;
  // final DataReview data;
  
  const PostReviewResponse({
    required this.code,
    required this.error,
    required this.message,
    // required this.data,
  });

  @override
  List<Object?> get props => [
        code,
        error,
        message,
        // data,
      ];
}
