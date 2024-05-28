import 'package:equatable/equatable.dart';

class UpdateProfileResponse extends Equatable {
  final int code;
  final String status;
  final bool error;
  final String message;

  const UpdateProfileResponse({
    required this.code,
    required this.status,
    required this.error,
    required this.message,
  });

  @override
  List<Object?> get props => [
        code,
        status,
        error,
        message,
      ];
}
