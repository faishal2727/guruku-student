// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';

class PackagesDetailModel extends Equatable {
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

  PackagesDetailModel({
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

  factory PackagesDetailModel.fromJson(Map<String, dynamic> json) {
    return PackagesDetailModel(
      id: json["data"]["id"],
      duration: json["data"]["duration"],
      name: json["data"]["name"],
      price: json["data"]["price"],
      desc: json["data"]["desc"],
      time: json["data"]["time"] is List
          ? List<String>.from(json["data"]["time"])
          : json["data"]["time"] is String
              ? [json["data"]["time"]]
              : [],
      day: json["data"]["day"] is List
          ? List<String>.from(json["data"]["day"])
          : json["data"]["day"] is String
              ? [json["data"]["day"]]
              : [],
      teacherId: json["data"]["teacher_id"],
      userId: json["data"]["user_id"],
      sessions: json["data"]["sessions"],
      teacher: TeacherModel.fromJson(
        json["data"]["teacher"],
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
