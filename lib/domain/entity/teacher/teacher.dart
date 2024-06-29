// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class Teacher extends Equatable {
  int id;
  String? username;
  String? name;
  String? email;
  String? avatar;
  String? picture;
  String? phone;
  String? typeTeaching;
  String? price;
  String? description;
  String? timeExperience;
  String? education;
  String? lat;
  String? lon;
  String? addess;
  String? rate;
  bool? isTeacher;

  Teacher({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.picture,
    required this.phone,
    required this.typeTeaching,
    required this.price,
    required this.description,
    required this.timeExperience,
    required this.education,
    required this.lat,
    required this.lon,
    required this.addess,
    required this.rate,
    required this.isTeacher,
  });

  Teacher.bookmark({
    required this.id,
    required this.name,
    required this.avatar,
    required this.addess,
    required this.price,
    required this.typeTeaching,
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
        typeTeaching,
        price,
        description,
        timeExperience,
        education,
        lat,
        lon,
        addess,
        rate,
        isTeacher,
      ];
}
