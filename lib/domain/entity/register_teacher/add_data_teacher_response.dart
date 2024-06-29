import 'package:equatable/equatable.dart';

class AddDataTeacherResponse extends Equatable {
  final int code;
  final String status;
  final bool error;
  final String message;

  const AddDataTeacherResponse({
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
