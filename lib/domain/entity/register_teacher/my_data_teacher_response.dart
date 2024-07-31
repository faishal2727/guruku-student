// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_schedule.dart';

class MyDataTeacherResponse extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  List<MySchedule>? schedule;
  List<String>? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? address;
  int? userId;
  String? balance;
  List<String>? skill;
  String? idCard;
  String? file;

  MyDataTeacherResponse({
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
    required this.userId,
    required this.balance,
    required this.skill,
    required this.idCard,
    required this.file,
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
        userId,
        balance,
        skill,
        idCard,
        file,
      ];
}
