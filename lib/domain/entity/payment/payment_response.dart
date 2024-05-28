import 'package:equatable/equatable.dart';

class PaymentResponse extends Equatable {
  final int code;
  final bool error;
  final String message;
  final String token;

  const PaymentResponse({
    required this.code,
    required this.error,
    required this.message,
    required this.token,
  });

  @override
  List<Object?> get props => [
        code,
        error,
        message,
        token,
      ];
}
