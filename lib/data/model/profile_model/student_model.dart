// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';

class StudentModel extends Equatable {
  int idStudent;
  String username;
  String email;
  String otp;

  StudentModel({
    required this.idStudent,
    required this.username,
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        "id": idStudent,
        "username": username,
        "email": email,
        "otp": otp,
      };

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        idStudent: json["id"],
        username: json["username"],
        email: json["email"],
        otp: json["otp"],
      );

  Student toEntity() => Student(
        idStudent: idStudent,
        username: username,
        email: email,
        otp: otp,
      );

  factory StudentModel.fromEntity(Student data) => StudentModel(
        idStudent: data.idStudent,
        username: data.username,
        email: data.email,
        otp: data.otp,
      );

  static StudentModel defaultInstance() {
    return StudentModel(
        idStudent: 0, username: 'username', email: 'email', otp: 'otp');
  }

  @override
  List<Object?> get props => [
        idStudent,
        username,
        email,
        otp,
      ];
}
