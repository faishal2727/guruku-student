// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class DetailProfileResponse extends Equatable {
  int? id;
  String? username;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? education;
  String? images;
  String? bod;
  String? address;
  String? lat;
  String? lon;
  String? gender;
  String? role;
  int? teacherId;
  String? balanceUser;
  String? status;
  Teacher? teacher;

  DetailProfileResponse({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.education,
    required this.images,
    required this.bod,
    required this.address,
    required this.lat,
    required this.lon,
    required this.gender,
    required this.role,
    required this.teacherId,
    required this.balanceUser,
    required this.status,
    required this.teacher,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        email,
        password,
        phone,
        education,
        images,
        bod,
        address,
        lat,
        lon,
        gender,
        role,
        teacherId,
        balanceUser,
        status,
        teacher,
      ];
}
