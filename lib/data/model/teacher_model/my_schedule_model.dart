
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/register_teacher/my_schedule.dart';

class MyScheduleModel extends Equatable {
  DateTime day;
  List<String> time;

  MyScheduleModel({
    required this.day,
    required this.time,
  });

  factory MyScheduleModel.fromJson(Map<String, dynamic> json) => MyScheduleModel(
        day: DateTime.parse(json["day"]),
        time: List<String>.from(json["time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "day": day.toIso8601String(),
        "time": List<dynamic>.from(time.map((x) => x)),
      };

  factory MyScheduleModel.fromEntity(MySchedule entity) => MyScheduleModel(
        day: entity.day,
        time: entity.time,
      );


  MySchedule toEntity() => MySchedule(
        day: day,
        time: time,
      );

  @override
  List<Object?> get props => [
        day,
        time,
      ];
}
