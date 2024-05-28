// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final String day;
  final List<String> time;

  Schedule({
    required this.day,
    required this.time,
  });

  @override
  List<Object?> get props => [day, time];
}
