// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/notif/notif_response.dart';

class NotifResponseModel extends Equatable {
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

  NotifResponseModel({
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

  factory NotifResponseModel.fromJson(Map<String, dynamic> json) =>
      NotifResponseModel(
        id: json["id"],
        idTeacher: json["id_teacher"],
        idStudent: json["id_student"],
        idOrder: json["id_order"],
        total: json["total"],
        va: json["va"],
        bank: json["bank"],
        paymentStatus: json["payment_status"],
        title: json["title"],
        desc: json["desc"],
        expired: DateTime.parse(json["expired"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_teacher": idTeacher,
        "id_student": idStudent,
        "id_order": idOrder,
        "total": total,
        "va": va,
        "bank": bank,
        "payment_status": paymentStatus,
        "title": title,
        "desc": desc,
        "expired": expired.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  NotifResponse toEntity() {
    return NotifResponse(
      id: id,
      idTeacher: idTeacher,
      idStudent: idStudent,
      idOrder: idOrder,
      total: total,
      va: va,
      bank: bank,
      paymentStatus: paymentStatus,
      title: title,
      desc: desc,
      expired: expired,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

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
