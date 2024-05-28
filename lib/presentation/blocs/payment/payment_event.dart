part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class DoPayment extends PaymentEvent {
  final int orderId;
  final int total;
  final String name;

  const DoPayment({
    required this.orderId,
    required this.total,
    required this.name,
  });
}
