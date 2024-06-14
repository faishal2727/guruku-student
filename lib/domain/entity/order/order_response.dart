import 'package:equatable/equatable.dart';
import 'package:guruku_student/domain/entity/order/data.dart';

class OrderResponse extends Equatable {
  final int code;
  final String status;
  final bool success;
  final String message;
  final Data data;

  const OrderResponse({
    required this.code,
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });
  
  @override
  List<Object?> get props => [
    code,
    status,
    success,
    message,
    data,
  ];
}