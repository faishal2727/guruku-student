// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class Packages extends Equatable {
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
  Teacher? teacher;

  Packages({
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
