import 'package:equatable/equatable.dart';

class WithdrawDetailResponse extends Equatable {
  final int id;
  final int userId;
  final int? teacherId;
  final String amount;
  final String status;
  final String noBank;
  final String nameBank;
  final String wd;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? note;

  const WithdrawDetailResponse({
    required this.id,
    required this.userId,
    required this.teacherId,
    required this.amount,
    required this.status,
    required this.noBank,
    required this.nameBank,
    required this.wd,
    required this.createdAt,
    required this.updatedAt,
    required this.note,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        teacherId,
        amount,
        status,
        noBank,
        nameBank,
        wd,
        createdAt,
        updatedAt,
        note,
      ];
}
