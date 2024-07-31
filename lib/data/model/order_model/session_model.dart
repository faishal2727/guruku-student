import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/history_order/session.dart';

class SessionModel extends Equatable {
  final int id;
  final int studentId;
  final String status;
  final int packageId;
  final int orderId;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SessionModel({
    required this.id,
    required this.studentId,
    required this.status,
    required this.packageId,
    required this.orderId,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        id: json['id'],
        studentId: json['student_id'],
        status: json['status'],
        packageId: json['packages_id'],
        orderId: json['order_id'],
        code: json['code'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'student_id': studentId,
        'status': status,
        'packages_id': packageId,
        'order_id': orderId,
        'code': code,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  Session toEntity() => Session(
        id: id,
        studentId: studentId,
        status: status,
        packageId: packageId,
        orderId: orderId,
        code: code,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        studentId,
        status,
        packageId,
        orderId,
        code,
        createdAt,
        updatedAt,
      ];
}
