import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MySchedule extends Equatable {
  DateTime day;
  List<String> time;

  MySchedule({
    required this.day,
    required this.time,
  });

  @override
  List<Object?> get props => [
        day,
        time,
      ];
}
