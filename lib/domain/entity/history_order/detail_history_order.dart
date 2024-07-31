import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/auth/student.dart';
import 'package:guruku_student/domain/entity/teacher/teacher.dart';

class DetailHistoryOrder extends Equatable {
  final int id;
  final String? code;
  final int? idStudent;
  final int? idTeacher;
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
  final Student student;
  final Teacher teacher;
  final String kehadiran;
  final String lat;
  final String lon;
  final String mapel;

  const DetailHistoryOrder({
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

  });

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
      ];
}
