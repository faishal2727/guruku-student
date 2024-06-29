// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/teacher/schedule.dart';

class ScheduleModel extends Equatable {
  String day;
  List<String> time;

  ScheduleModel({
    required this.day,
    required this.time,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        day: json["day"],
        time: List<String>.from(json["time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": List<dynamic>.from(time.map((x) => x)),
      };

  Schedule toEntity() {
    return Schedule(day: day, time: time);
  }

  factory ScheduleModel.fromEntity(Schedule entity) {
    return ScheduleModel(
      day: entity.day,
      time: entity.time,
    );
  }
  @override
  List<Object?> get props => [day, time];
}
