import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';
import 'package:guruku_student/domain/entity/teacher/packages.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class DataHistoryOrderPackages extends Equatable {
  final int id;
  final int? idStudent;
  final int? idTeacher;
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
  final Student student;
  final Teacher teacher;
  final Packages packages;

  const DataHistoryOrderPackages({
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
