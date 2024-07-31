// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';
import 'package:guruku_student/domain/entity/teacher/histories.dart';
import 'package:guruku_student/domain/entity/teacher/schedule.dart';

class TeacherDetail extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  List<Schedule>? schedule;
  List<String>? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? address;
  String? rate;
  List<Histories> histories;
  int? userId;
  Student? student;
  String? gelar;
  String? jurusan;
  String? tahunLulus;
  String? balance;
  List<String>? skill;

  TeacherDetail({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.picture,
    required this.phone,
    required this.schedule,
    required this.typeTeaching,
    required this.price,
    required this.description,
    required this.timeExperience,
    required this.education,
    required this.lat,
    required this.lon,
    required this.address,
    required this.rate,
    required this.histories,
    required this.userId,
    required this.student,
    required this.gelar,
    required this.jurusan,
    required this.tahunLulus,
    required this.balance,
    required this.skill,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        email,
        avatar,
        picture,
        phone,
        schedule,
        typeTeaching,
        price,
        description,
        timeExperience,
        education,
        lat,
        lon,
        address,
        rate,
        histories,
        userId,
        student,
        gelar,
        jurusan,
        tahunLulus,
        balance,
        skill,
      ];
}
