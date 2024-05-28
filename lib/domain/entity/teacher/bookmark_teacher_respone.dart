// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class BookmarkTeacherResponse extends Equatable {
  int code;
  String status;
  bool success;
  String message;

  BookmarkTeacherResponse({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
      ];
}
