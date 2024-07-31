import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final int id;
  final int studentId;
  final String status;
  final int packageId;
  final int orderId;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Session({
    required this.id,
    required this.studentId,
    required this.status,
    required this.packageId,
    required this.orderId,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

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
