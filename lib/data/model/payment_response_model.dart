import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/payment/payment_response.dart';

class PaymentReposneModel extends Equatable {
  final int code;
  final bool error;
  final String message;
  final String token;

  const PaymentReposneModel({
    required this.code,
    required this.error,
    required this.message,
    required this.token,
  });

  Map<String, dynamic> toJson() => {
        'code': code,
        'error': error,
        'message': message,
        'token': token,
      };

  factory PaymentReposneModel.fromJson(Map<String, dynamic> json) =>
      PaymentReposneModel(
        code: json['code'],
        error: json['error'],
        message: json['message'],
        token: json['token'],
      );

  PaymentResponse toEntity() => PaymentResponse(
        code: code,
        error: error,
        message: message,
        token: token,
      );

  factory PaymentReposneModel.fromEntity(PaymentResponse data) =>
      PaymentReposneModel(
        code: data.code,
        error: data.error,
        message: data.message,
        token: data.token,
      );

  @override
  List<Object?> get props => [
        code,
        error,
        message,
        token,
      ];
}
