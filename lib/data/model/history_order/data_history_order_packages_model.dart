import 'package:equatable/equatable.dart';
import 'package:guruku_student/data/model/profile_model/student_model.dart';
import 'package:guruku_student/data/model/teacher_model/packages_model_uye.dart';
import 'package:guruku_student/data/model/teacher_model/teacher_model.dart';
import 'package:guruku_student/domain/entity/history_order/data_history_order_packages_uye.dart';

class DataHistoryOrderPackagesModel extends Equatable {
  final int id;
  final int idStudent;
  final int idTeacher;
  final int? total;
  final String? onBehalf;
  final String? address;
  final String? phone;
  final String? email;
  final DateTime? meetingTime;
  final bool? present;
  final String? paymentStatus;
  final DateTime? expired;
  final String? va;
  final String? bank;
  final int? reviewId;
  final String? kehadiran;
  final String? lat;
  final String? lon;
  final String? mapel;
  final int? packageId;
  final String? time;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final StudentModel student;
  final TeacherModel teacher;
  final PackagesModelUye packages;

  const DataHistoryOrderPackagesModel({
    required this.id,
    required this.idStudent,
    required this.idTeacher,
    required this.total,
    required this.onBehalf,
    required this.address,
    required this.phone,
    required this.email,
    required this.meetingTime,
    required this.present,
    required this.paymentStatus,
    required this.expired,
    required this.va,
    required this.bank,
    required this.reviewId,
    required this.kehadiran,
    required this.lat,
    required this.lon,
    required this.mapel,
    required this.packageId,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.student,
    required this.teacher,
    required this.packages,
  });

  factory DataHistoryOrderPackagesModel.fromJson(Map<String, dynamic> json) =>
      DataHistoryOrderPackagesModel(
        id: json['id'],
        idStudent: json["id_student"],
        idTeacher: json["id_teacher"],
        total: json["total"],
        onBehalf: json["on_behalf"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        meetingTime: DateTime.parse(json["meeting_time"]),
        present: json["present"],
        paymentStatus: json["payment_status"],
        expired: DateTime.parse(json["expired"]),
        va: json["va"],
        bank: json["bank"],
        reviewId: json["review_id"],
        kehadiran: json["kehadiran"],
        lat: json["lat"],
        lon: json["lon"],
        mapel: json["mapel"],
        packageId: json["package_id"],
        time: json["time"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        student: StudentModel.fromJson(json["student"]),
        teacher: TeacherModel.fromJson(json["teacher"]),
        packages: PackagesModelUye.fromJson(json["packages"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_student": idStudent,
        "id_teacher": idTeacher,
        "total": total,
        "on_behalf": onBehalf,
        "address": address,
        "phone": phone,
        "email": email,
        "meeting_time": meetingTime?.toIso8601String(),
        "present": present,
        "payment_status": paymentStatus,
        "expired": expired?.toIso8601String(),
        "va": va,
        "bank": bank,
        "review_id": reviewId,
        "kehadiran": kehadiran,
        "lat": lat,
        "lon": lon,
        "mapel": mapel,
        "package_id": packageId,
        "time": time,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "student": student.toJson(),
        "teacher": teacher.toJson(),
        "packages": packages.toJson(),
      };

  DataHistoryOrderPackagesUye toEntity() => DataHistoryOrderPackagesUye(
        id: id,
        idStudent: idStudent,
        idTeacher: idTeacher,
        total: total,
        onBehalf: onBehalf,
        address: address,
        phone: phone,
        email: email,
        meetingTime: meetingTime,
        present: present,
        paymentStatus: paymentStatus,
        expired: expired,
        va: va,
        bank: bank,
        reviewId: reviewId,
        kehadiran: kehadiran,
        lat: lat,
        lon: lon,
        mapel: mapel,
        packageId: packageId,
        time: time,
        createdAt: createdAt,
        updatedAt: updatedAt,
        student: student.toEntity(),
        teacher: teacher.toEntity(),
        packages: packages.toEntity(),
      );

  @override
  List<Object?> get props => [
        id,
        idStudent,
        idTeacher,
        total,
        onBehalf,
        address,
        phone,
        email,
        meetingTime,
        present,
        paymentStatus,
        expired,
        va,
        bank,
        reviewId,
        kehadiran,
        lat,
        lon,
        mapel,
        packageId,
        time,
        createdAt,
        updatedAt,
        student,
        teacher,
        packages,
      ];
}
