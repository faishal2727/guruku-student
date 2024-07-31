import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';

class WithdrawDetailResponseModel extends Equatable {
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

  const WithdrawDetailResponseModel({
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
    this.note, // note can be null
  });

  factory WithdrawDetailResponseModel.fromJson(Map<String, dynamic> json) {
  print("Debug JSON: $json"); // Debug print
  return WithdrawDetailResponseModel(
    id: json["id"] ?? 5,
    userId: json["user_id"] ?? 0,
    teacherId: json["teacher_id"] as int?, // teacherId can be null, so use 'as int?' for nullable type
    amount: json["amount"] ?? '',
    status: json["status"] ?? '',
    noBank: json["bank_account_number"] ?? '',
    nameBank: json["bank_name"] ?? '',
    wd: json["transaction_fee"] ?? '',
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    note: json["note"] ?? '', // note can be null
  );
}


  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "teacher_id": teacherId,
    "amount": amount,
    "status": status,
    "bank_account_number": noBank,
    "bank_name": nameBank,
    "transaction_fee": wd,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "note": note,
  };

  WithdrawDetailResponse toEntity() {
    return WithdrawDetailResponse(
      id: id,
      userId: userId,
      teacherId: teacherId,
      amount: amount,
      status: status,
      noBank: noBank,
      nameBank: nameBank,
      wd: wd,
      createdAt: createdAt,
      updatedAt: updatedAt,
      note: note, // note can be null
    );
  }

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
