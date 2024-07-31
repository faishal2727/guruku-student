import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order.dart';

class DataHistoryOrderModel extends Equatable {
  final int id;
  final String code;
  final int idStudent;
  final int idTeacher;
  final int? total;
  final String? onBehalf;
  final String? note;
  final String? phone;
  final String? email;
  final DateTime? meetingTime;
  final bool? present;
  final String? paymentStatus;
  final DateTime? expired;
  final String? va;
  final String? bank;
  final StudentModel student;
  final TeacherModel teacher;
  final String? mapel;

  const DataHistoryOrderModel({
    required this.id,
    required this.code,
    required this.idStudent,
    required this.idTeacher,
    required this.total,
    required this.onBehalf,
    required this.note,
    required this.phone,
    required this.email,
    required this.meetingTime,
    required this.present,
    required this.paymentStatus,
    required this.expired,
    required this.va,
    required this.bank,
    required this.student,
    required this.teacher,
    required this.mapel,
  });

  factory DataHistoryOrderModel.fromJson(Map<String, dynamic> json) =>
      DataHistoryOrderModel(
        id: json['id'],
        code: json["code"],
        idStudent: json["id_student"],
        idTeacher: json["id_teacher"],
        total: json["total"],
        onBehalf: json["on_behalf"],
        note: json["note"],
        phone: json["phone"],
        email: json["email"],
        meetingTime: DateTime.parse(json["meeting_time"]),
        present: json["present"],
        paymentStatus: json["payment_status"],
        expired: DateTime.parse(json["expired"]),
        va: json["va"],
        bank: json["bank"],
        student: StudentModel.fromJson(json["student"]),
        teacher: TeacherModel.fromJson(json["teacher"]),
        mapel: json["mapel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "id_student": idStudent,
        "id_teacher": idTeacher,
        "total": total,
        "on_behalf": onBehalf,
        "note": note,
        "phone": phone,
        "email": email,
        "meeting_time": meetingTime,
        "present": present,
        "payment_status": paymentStatus,
        "expired": expired,
        "va": va,
        "bank": bank,
        "student": student.toJson(),
        "teacher": teacher.toJson(),
        "mapel": mapel,
      };

  DataHistoryOrder toEntity() => DataHistoryOrder(
        id: id,
        code: code,
        idStudent: idStudent,
        idTeacher: idTeacher,
        total: total,
        onBehalf: onBehalf,
        note: note,
        phone: phone,
        email: email,
        meetingTime: meetingTime,
        present: present,
        paymentStatus: paymentStatus,
        expired: expired,
        va: va,
        bank: bank,
        student: student.toEntity(),
        teacher: teacher.toEntity(),
        mapel: mapel,
      );

  @override
  List<Object?> get props => [
        id,
        code,
        idStudent,
        idTeacher,
        total,
        onBehalf,
        note,
        phone,
        email,
        meetingTime,
        present,
        paymentStatus,
        expired,
        va,
        bank,
        mapel,
        // student,
        // teacher,
      ];
}
