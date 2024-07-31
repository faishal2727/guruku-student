import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/withdraw/withdraw_detail_response.dart';

class DetailWdModel extends Equatable {
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

  const DetailWdModel({
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
    this.note,
  });

  factory DetailWdModel.fromJson(Map<String, dynamic> json) {
    print("Debug JSON: $json");
    return DetailWdModel(
      id: json["data"]["id"],
      userId: json["data"]["user_id"],
      teacherId: json["data"]["teacher_id"] as int?,
      amount: json["data"]["amount"].toString(),
      status: json["data"]["status"],
      noBank: json["data"]["bank_account_number"],
      nameBank: json["data"]["bank_name"],
      wd: json["data"]["transaction_fee"].toString(),
      createdAt: json["data"]["createdAt"] != null
          ? DateTime.parse(json["data"]["createdAt"])
          : DateTime.now(),
      updatedAt: json["data"]["updatedAt"] != null
          ? DateTime.parse(json["data"]["updatedAt"])
          : DateTime.now(),
      note: json["data"]["note"], // note can be null
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
