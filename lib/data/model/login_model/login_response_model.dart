import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/login_response.dart';

class LoginResonseModel extends Equatable {
  final String message;
  final String username;
  final String token;

  const LoginResonseModel({
    required this.message,
    required this.username,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'message': message,
        'username': username,
        'token': token,
      };

  factory LoginResonseModel.fromJson(Map<String, dynamic> json) =>
      LoginResonseModel(
        message: json['message'],
        username: json['username'],
        token: json['token'],
      );

  LoginResponse toEntity() => LoginResponse(
        message: message,
        username: username,
        token: token,
      );

  factory LoginResonseModel.fromEntity(LoginResponse data) => LoginResonseModel(
        message: data.message,
        username: data.username,
        token: data.token,
      );

  @override
  List<Object?> get props => [
        message,
        username,
        token,
      ];
}
