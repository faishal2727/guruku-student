// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';

class PackagesModel extends Equatable {
  int id;
  int? duration;
  String? name;
  int? price;
  String? desc;
  List<String>? time;
  List<String>? day;
  int? teacherId;
  int? userId;
  int? sessions;
  TeacherModel teacher;

  PackagesModel({
    required this.id,
    required this.duration,
    required this.name,
    required this.price,
    required this.desc,
    required this.time,
    required this.day,
    required this.teacherId,
    required this.userId,
    required this.sessions,
    required this.teacher,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    return PackagesModel(
      id: json["id"],
      duration: json["duration"],
      name: json["name"],
      price: json["price"],
      desc: json["desc"],
      time: json["time"] is List
          ? List<String>.from(json["time"])
          : json["time"] is String
              ? [json["time"]]
              : [],
      day: json["day"] is List
          ? List<String>.from(json["day"])
          : json["day"] is String
              ? [json["day"]]
              : [],
      teacherId: json["teacher_id"],
      userId: json["user_id"],
      sessions: json["sessions"],
      teacher: TeacherModel.fromJson(
        json["teacher"],
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "duration": duration,
        "name": name,
        "price": price,
        "desc": desc,
        "time": time,
        "day": day,
        "teacher_id": teacherId,
        "user_id": userId,
        "sessions": sessions,
        "teacher": teacher,
      };

  Packages toEntity() {
    return Packages(
        id: id,
        duration: duration,
        name: name,
        price: price,
        desc: desc,
        time: time,
        day: day,
        teacherId: teacherId,
        userId: userId,
        sessions: sessions,
        teacher: teacher.toEntity());
  }

  @override
  List<Object?> get props => [
        id,
        duration,
        name,
        price,
        desc,
        time,
        day,
        teacherId,
        userId,
        sessions,
        teacher,
      ];
}


