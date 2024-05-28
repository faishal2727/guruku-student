// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String message;
  final String username;
  final String token;

  LoginResponse({
    required this.message,
    required this.username,
    required this.token,
  });

  @override
  List<Object?> get props => [
        message,
        username,
        token,
      ];
}
