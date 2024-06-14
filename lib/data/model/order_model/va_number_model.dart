import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/order/va_number.dart';

class VaNumberModel extends Equatable {
  final String bank;
  final String vaNumber;

  const VaNumberModel({
    required this.bank,
    required this.vaNumber,
  });

  factory VaNumberModel.fromJson(Map<String, dynamic> json) => VaNumberModel(
        bank: json["bank"],
        vaNumber: json["va_number"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "va_number": vaNumber,
      };

  VaNumber toEntity() => VaNumber(
        bank: bank,
        vaNumber: vaNumber,
      );

  @override
  List<Object?> get props => [
        bank,
        vaNumber,
      ];
}
