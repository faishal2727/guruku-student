// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String message;
  final String username;
  final String token;
  final String role;
  final int idStudent;


  LoginResponse({
    required this.message,
    required this.username,
    required this.token,
    required this.role,
    required this.idStudent,
  });

  @override
  List<Object?> get props => [
        message,
        username,
        token,
        role,
        idStudent,
      ];
}
