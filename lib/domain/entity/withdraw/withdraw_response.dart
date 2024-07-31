
import 'package:equatable/equatable.dart';

class WithdrawResponse extends Equatable {
  final int code;
  final String status;
  final bool success;
  final String message;
  
  const WithdrawResponse({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
  });

  @override
  List<Object?> get props => [
        code,
        status,
        success,
        message,
      ];
}
