// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class NotifResponse extends Equatable {
  int id;
  int idTeacher;
  int idStudent;
  String idOrder;
  int total;
  String va;
  String bank;
  String paymentStatus;
  String title;
  String desc;
  DateTime expired;
  DateTime createdAt;
  DateTime updatedAt;

  NotifResponse({
    required this.id,
    required this.idTeacher,
    required this.idStudent,
    required this.idOrder,
    required this.total,
    required this.va,
    required this.bank,
    required this.paymentStatus,
    required this.title,
    required this.desc,
    required this.expired,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        idTeacher,
        idStudent,
        idOrder,
        total,
        va,
        bank,
        paymentStatus,
        title,
        desc,
        expired,
        createdAt,
        updatedAt,
      ];
}
