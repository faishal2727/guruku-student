import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order.dart';

class DataDetailHistoryOrderModel extends Equatable {
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
  final int? reviewId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final StudentModel student;
  final TeacherModel teacher;
  final String kehadiran;

  const DataDetailHistoryOrderModel({
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
    required this.reviewId,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.teacher,
    required this.kehadiran,
  });

  factory DataDetailHistoryOrderModel.fromJson(Map<String, dynamic> json) =>
      DataDetailHistoryOrderModel(
        id: json["data"]['id'],
        code: json["data"]["code"],
        idStudent: json["data"]["id_student"],
        idTeacher: json["data"]["id_teacher"],
        total: json["data"]["total"],
        onBehalf: json["data"]["on_behalf"],
        note: json["data"]["note"],
        phone: json["data"]["phone"],
        email: json["email"],
        meetingTime: DateTime.parse(json["data"]["meeting_time"]),
        present: json["data"]["present"],
        paymentStatus: json["data"]["payment_status"],
        expired: DateTime.parse(json["data"]["expired"]),
        va: json["data"]["va"],
        bank: json["data"]["bank"],
        reviewId: json["data"]["review_id"],
        createdAt: DateTime.parse(json["data"]["createdAt"]),
        updatedAt: DateTime.parse(json["data"]["updatedAt"]),
        student: StudentModel.fromJson(json["data"]["student"]),
        teacher: TeacherModel.fromJson(json["data"]["teacher"]),
        kehadiran: json["data"]["kehadiran"]
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
        "review_id": reviewId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "student": student.toJson(),
        "teachet": teacher.toJson(),
        "kehadiran": kehadiran,
      };

  DetailHistoryOrder toEntity() => DetailHistoryOrder(
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
        reviewId: reviewId,
        createdAt: createdAt,
        updatedAt: updatedAt,
        student: student.toEntity(),
        teacher: teacher.toEntity(),
        kehadiran: kehadiran,
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
        reviewId,
        createdAt,
        updatedAt,
        student,
        teacher,
        kehadiran,
      ];
}
