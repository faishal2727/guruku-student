import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/login_response.dart';

class LoginResonseModel extends Equatable {
  final String message;
  final String username;
  final String token;
  final String role;
  final int idStudent;

  const LoginResonseModel({
    required this.message,
    required this.username,
    required this.token,
    required this.role,
    required this.idStudent,
  });

  Map<String, dynamic> toJson() => {
        'message': message,
        'username': username,
        'token': token,
        'role': role,
        'idStudent': idStudent,
      };

  factory LoginResonseModel.fromJson(Map<String, dynamic> json) =>
      LoginResonseModel(
        message: json['message'],
        username: json['username'],
        token: json['token'],
        role: json['role'],
        idStudent: json['idStudent']
      );

  LoginResponse toEntity() => LoginResponse(
        message: message,
        username: username,
        token: token,
        role: role,
        idStudent: idStudent,
      );

  factory LoginResonseModel.fromEntity(LoginResponse data) => LoginResonseModel(
        message: data.message,
        username: data.username,
        token: data.token,
        role: data.role,
        idStudent: data.idStudent,
      );

  @override
  List<Object?> get props => [
        message,
        username,
        token,
        role,
        idStudent,
      ];
}
