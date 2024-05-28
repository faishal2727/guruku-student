// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';

class StudentModel extends Equatable {
  String username;
  String email;
  String otp;

  StudentModel({
    required this.username,
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "otp": otp,
      };

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
        username: json["username"],
        email: json["email"],
        otp: json["otp"],
      );

  Student toEntity() => Student(
        username: username,
        email: email,
        otp: otp,
      );

  factory StudentModel.fromEntity(Student data) => StudentModel(
        username: data.username,
        email: data.email,
        otp: data.otp,
      );

  @override
  List<Object?> get props => [
        username,
        email,
        otp,
      ];
}
