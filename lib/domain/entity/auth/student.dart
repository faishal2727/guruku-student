// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Student extends Equatable {
  int idStudent;
  String username;
  String email;
  String otp;

  Student({
    required this.idStudent,
    required this.username,
    required this.email,
    required this.otp,
  });

  @override
  List<Object?> get props => [
        idStudent,
        username,
        email,
        otp,
      ];
}
