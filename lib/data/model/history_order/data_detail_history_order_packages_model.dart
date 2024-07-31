import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/order_model/session_model.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/teacher_model/packages_model_uye.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/history_order/detail_history_order_package.dart';

class DataDetailHistoryOrderPackagesModel extends Equatable {
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
  final String lat;
  final String lon;
  final String mapel;
  final int? packageId;
  final String? time;
  final String? address;
  final PackagesModelUye packages;
  final List<SessionModel>? sessions;

  const DataDetailHistoryOrderPackagesModel({
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
    required this.lat,
    required this.lon,
    required this.mapel,
    required this.packageId,
    required this.time,
    required this.address,
    required this.packages,
    required this.sessions,
  });

  factory DataDetailHistoryOrderPackagesModel.fromJson(
          Map<String, dynamic> json) =>
      DataDetailHistoryOrderPackagesModel(
        id: json["data"]['id'],
        code: json["data"]["code"],
        idStudent: json["data"]["id_student"],
        idTeacher: json["data"]["id_teacher"],
        total: json["data"]["total"],
        onBehalf: json["data"]["on_behalf"],
        note: json["data"]["note"],
        phone: json["data"]["phone"],
        email: json["data"]["email"],
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
        kehadiran: json["data"]["kehadiran"],
        lat: json["data"]["lat"],
        lon: json["data"]["lon"],
        mapel: json["data"]["mapel"],
        packageId: json["data"]["package_id"],
        time: json["data"]["time"],
        address: json["data"]["address"],
        packages: PackagesModelUye.fromJson(
          json["data"]["packages"],
        ),
        sessions: (json["data"]["sessions"] as List<dynamic>?)
            ?.map((e) => SessionModel.fromJson(e))
            .toList(),
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
        "meeting_time": meetingTime?.toIso8601String(),
        "present": present,
        "payment_status": paymentStatus,
        "expired": expired?.toIso8601String(),
        "va": va,
        "bank": bank,
        "review_id": reviewId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "student": student.toJson(),
        "teacher": teacher.toJson(),
        "kehadiran": kehadiran,
        "lat": lat,
        "lon": lon,
        "mapel": mapel,
        "package_id": packageId,
        "time": time,
        "address": address,
        "packages": packages.toJson(),
        "sessions": sessions?.map((e) => e.toJson()).toList(),
      };

  DetailHistoryOrderPackage toEntity() => DetailHistoryOrderPackage(
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
        lat: lat,
        lon: lon,
        mapel: mapel,
        packageId: packageId,
        time: time,
        address: address,
        packages: packages.toEntity(),
        sessions: sessions?.map((e) => e.toEntity()).toList(),
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
        lat,
        lon,
        mapel,
        packageId,
        time,
        address,
        packages,
        sessions,
      ];
}
