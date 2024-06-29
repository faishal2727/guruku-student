import 'package:equatable/equatable.dart';

class ReviewResponse extends Equatable {
  final int code;
  final bool error;
  final String message;
  
  const ReviewResponse({
    required this.code,
    required this.error,
    required this.message,
  });

  @override
  List<Object?> get props => [
        code,
        error,
        message,
      ];
}
