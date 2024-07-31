
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class PackagesUye extends Equatable {
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

  PackagesUye({
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
      ];
}
